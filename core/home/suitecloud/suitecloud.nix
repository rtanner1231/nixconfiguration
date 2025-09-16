{ pkgs, ... }:
let
  sdfFileName = "cli-2025.1.0.jar";
  basePath = "https://system.netsuite.com/download/suitecloud-sdk/25.1";
  suiteCloudCliJar = pkgs.fetchurl {
    url = "${basePath}/${sdfFileName}";
    sha256 = "sha256-tOMCF1v3TvVSa5Hi+NLD8+c/jopXP6b/+GlPvMy86JM=";
  };

in
{

  home.packages = with pkgs; [
    (callPackage ./suitecloud-cli.nix { })
  ];

  home.file = {
    "/.suitecloud-sdk/cli/${sdfFileName}" = {
      source = suiteCloudCliJar;
    };
  };
}
