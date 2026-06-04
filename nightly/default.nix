{ stdenvNoCC, fetchurl, lib }:
let
  sources = {
    x86_64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_amd64.tar.gz";
      hash = "sha256-oES6QKK0qwdv0rGBXMyJhNLGGX6gcMZKJ6ypiYlFRMA=";
    };
    aarch64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_arm64.tar.gz";
      hash = "sha256-oUQuC1vao7FmUmIURS4vsJVgjOSTrqrrgoNfaX+ZF2g=";
    };
    x86_64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_amd64.tar.gz";
      hash = "sha256-6/61jWlRjt8UmOg82GzT+R0Jg2IUXJIl1OFVcLWQSfs=";
    };
    aarch64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_arm64.tar.gz";
      hash = "sha256-gFSHL3VxRN58Uu2tHL+ibQTKaNHBb0QVhRveBXL4ZAE=";
    };
  };
  src = sources.${stdenvNoCC.hostPlatform.system}
    or (throw "matcha-nightly: unsupported system ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "matcha-nightly";
  version = "nightly-b3fd04c";
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
