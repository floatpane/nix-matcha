{ stdenvNoCC, fetchurl, lib }:
let
  sources = {
    x86_64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_amd64.tar.gz";
      hash = "sha256-/2C4CqIQmH0JwE8cgrdk3AfjCFImgKJp7HUtOpTsDKk=";
    };
    aarch64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_arm64.tar.gz";
      hash = "sha256-AqUQ2s8IzUWOPXBd4Zo8upjUCMFV7D/fiCv99MpKqTc=";
    };
    x86_64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_amd64.tar.gz";
      hash = "sha256-nPYvflR1o87Rv9KkjpNVEigsUztuSPBzieaBOvgzLx8=";
    };
    aarch64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_arm64.tar.gz";
      hash = "sha256-CuLrABA6UT4ifYZJi0bqT+DFb/9pjY44g7xXldrErs8=";
    };
  };
  src = sources.${stdenvNoCC.hostPlatform.system}
    or (throw "matcha-nightly: unsupported system ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "matcha-nightly";
  version = "nightly-d4bd3bb";
  src = fetchurl src;
  sourceRoot = ".";
  installPhase = ''
    runHook preInstall
    install -Dm755 matcha $out/bin/matcha
    runHook postInstall
  '';
  meta = {
    description = "Beautiful and functional email client for the terminal (nightly)";
    homepage = "https://matcha.email";
    license = lib.licenses.mit;
    mainProgram = "matcha";
    platforms = builtins.attrNames sources;
  };
}
