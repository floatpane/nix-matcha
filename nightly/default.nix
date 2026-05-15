{ stdenvNoCC, fetchurl, lib }:
let
  sources = {
    x86_64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_amd64.tar.gz";
      hash = "sha256-YtPedfvIlNI5ZmOQ227dyFiaevi+TWrME2dhPO1KfcU=";
    };
    aarch64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_arm64.tar.gz";
      hash = "sha256-YYpRriSVFDi5CKN0IJIMhRUCoYfnhRc7nZcGqeV0UN8=";
    };
    x86_64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_amd64.tar.gz";
      hash = "sha256-auila1vedIkiPHFG6ZlpPqKTQRP4X3ZQKM8tSfVpMrM=";
    };
    aarch64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_arm64.tar.gz";
      hash = "sha256-25YUoXccPd5KhAY+1eulKsbH4E3lwXNKUuTy2mLq178=";
    };
  };
  src = sources.${stdenvNoCC.hostPlatform.system}
    or (throw "matcha-nightly: unsupported system ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "matcha-nightly";
  version = "nightly-6e2d9e7";
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
