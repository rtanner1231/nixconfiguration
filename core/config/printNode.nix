{
  config,
  pkgs,
  lib,
  ...
}:

let
  printnodeFhs = pkgs.buildFHSEnv {
    name = "printnode-fhs";
    targetPkgs =
      p:
      (with p; [
        # Core PrintNode integrations
        cups
        libusb1
        systemd # provides libudev

        # Security & Networking (pycurl runtime)
        libpsl
        libidn2
        nghttp2
        libssh2
        brotli
        zstd
        krb5
        openssl
        curl
        libxcrypt-legacy

        # Common Linux dynamic dependencies
        zlib
        fontconfig
        freetype
        glib
        dbus
        expat
      ])
      ++ (pkgs.appimageTools.defaultFhsEnvArgs.targetPkgs p);

    runScript = pkgs.writeScript "printnode-runner" ''
      #!/usr/bin/env bash
      if [ $# -eq 0 ]; then
        exec bash
      else
        exec "$@"
      fi
    '';
  };

  startPrintNode = pkgs.writeShellScriptBin "startPrintNode" ''
    set -e

    DIR="''${PRINTNODE_DIR:-$HOME/.local/share/printnode}"
    PIDFILE="$DIR/printnode.pid"
    BINARY="$DIR/PrintNode"

    mkdir -p "$DIR"
    cd "$DIR"

    # Clean up any stale process holding port 8888
    if ${pkgs.psmisc}/bin/fuser 8888/tcp 2>/dev/null; then
      echo "Releasing port 8888..."
      ${pkgs.psmisc}/bin/fuser -k 8888/tcp 2>/dev/null || true
      sleep 1
    fi

    # Automatically fetch binary if not present
    if [ ! -f "$BINARY" ]; then
      echo "Downloading PrintNode client (Ubuntu x86_64 build)..."
      TARBALL="$DIR/printnode.tar.gz"
      ${pkgs.curl}/bin/curl -fSL "https://dl.printnode.com/client/printnode/4.28.23/PrintNode-4.28.23-ubuntu-24.04-x86_64.tar.gz" -o "$TARBALL"

      echo "Extracting archive..."
      ${pkgs.gnutar}/bin/tar -xzf "$TARBALL" -C "$DIR"
      rm -f "$TARBALL"

      if [ ! -f "$BINARY" ]; then
        SUBDIR=$(${pkgs.findutils}/bin/find "$DIR" -mindepth 1 -maxdepth 2 -name PrintNode -printf '%h\n' | head -n 1)
        if [ -n "$SUBDIR" ] && [ "$SUBDIR" != "$DIR" ]; then
          mv "$SUBDIR"/* "$DIR/"
        fi
      fi

      chmod +x "$BINARY"
    fi

    FLAGS="--headless --web-interface --remove-scales-support"

    if [ "$1" = "--fg" ] || [ "$1" = "--foreground" ]; then
      echo "Starting PrintNode in foreground (press Ctrl+C to stop)..."
      exec ${printnodeFhs}/bin/printnode-fhs "$BINARY" $FLAGS
    else
      echo "Starting PrintNode daemon in background..."
      # Feeding 'sleep infinity' keeps stdin open without sending EOF
      ${pkgs.coreutils}/bin/sleep infinity | ${printnodeFhs}/bin/printnode-fhs "$BINARY" $FLAGS > "$DIR/printnode.log" 2>&1 &
      PID=$!
      echo $PID > "$PIDFILE"
      sleep 2

      if ! kill -0 "$PID" 2>/dev/null; then
        echo "Error: PrintNode failed to start. Log output:"
        echo "---------------------------------------------------"
        cat "$DIR/printnode.log"
        echo "---------------------------------------------------"
        rm -f "$PIDFILE"
        exit 1
      fi

      echo "PrintNode started successfully (PID: $PID)."
      echo "  • Web UI:   http://127.0.0.1:8888"
      echo "  • Log file: $DIR/printnode.log"
    fi
  '';

  stopPrintNode = pkgs.writeShellScriptBin "stopPrintNode" ''
    DIR="''${PRINTNODE_DIR:-$HOME/.local/share/printnode}"
    PIDFILE="$DIR/printnode.pid"

    echo "Stopping PrintNode..."

    ${pkgs.procps}/bin/pkill -CONT -f "PrintNode" 2>/dev/null || true

    if [ -f "$PIDFILE" ]; then
      PID=$(cat "$PIDFILE")
      kill "$PID" 2>/dev/null || true
      rm -f "$PIDFILE"
    fi

    ${pkgs.procps}/bin/pkill -TERM -f "PrintNode" 2>/dev/null || true
    ${pkgs.procps}/bin/pkill -TERM -f "sleep infinity" 2>/dev/null || true
    sleep 1
    ${pkgs.procps}/bin/pkill -KILL -f "PrintNode" 2>/dev/null || true

    ${pkgs.psmisc}/bin/fuser -k 8888/tcp 2>/dev/null || true

    echo "PrintNode stopped."
  '';
in
{
  services.printing = {
    enable = true;
    cups-pdf.enable = true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "PDF";
        location = "Local Virtual Printer";
        deviceUri = "cups-pdf:/";
        model = "raw";
      }
    ];
    ensureDefaultPrinter = "PDF";
  };

  environment.systemPackages = [
    pkgs.psmisc
    printnodeFhs
    startPrintNode
    stopPrintNode
  ];
}
