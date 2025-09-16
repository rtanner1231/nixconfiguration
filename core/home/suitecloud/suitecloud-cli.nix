{
  lib,
  pkgs,
  buildNpmPackage,
  fetchurl,
  nodejs_22,
}:
buildNpmPackage rec {
  pname = "@oracle/suitecloud-cli";
  version = "3.0.2";

  src = fetchurl {
    url = "https://registry.npmjs.org/@oracle/suitecloud-cli/-/suitecloud-cli-${version}.tgz";
    sha256 = "sha256-cBBpIqcz4mVAEWU0RhrVdehfPUW6s+i5aQ/pCvZKr5Q=";
  };

  npmDepsHash = "sha256-OHpzdQV8HpgEACDGr2vtmSzS36/kLxNwnVDH0FaIbq0=";

  makeCacheWritable = true;

  npmFlags = [ "--ignore-scripts" ];

  # Copy in the package-lock file
  # The postinstall script is not compatable with nix.  We need to patch it out of the package.json file
  postPatch = ''
    cp ${./package-lock.json} ./package-lock.json

    sed -i.bak '/,$/{ N; /"postinstall": "node postinstall.js"/s/,\n.*//; }' ./package.json
  '';

  nativeBuildInputs = [
    nodejs_22
    pkgs.openjdk
    pkgs.jq
  ];

  dontNpmBuild = true;

  meta = with lib; {
    description = "Command-line interface for developing on the SuiteCloud platform";
    homepage = "https://www.npmjs.com/package/@oracle/suitecloud-cli";
    license = licenses.unfree;
    maintainers = [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
