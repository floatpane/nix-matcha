{ stdenvNoCC, fetchurl, lib }:
let
  sources = {
    x86_64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_amd64.tar.gz";
      hash = "sha256-CKbrTOTsm8Hlgd+H69tORBPwZP0ue2pETfy+jOnFMt0=";
    };
    aarch64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_arm64.tar.gz";
      hash = "sha256-c7PB9POxYuJLt59r2a6B+4oNeCG6vsFs3BNUjqrMJtU=";
    };
    x86_64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_amd64.tar.gz";
      hash = "sha256-tZQjoTDUODSSvdthRsHYPrNhtjN/sHUVEdJKWGWMq9s=";
    };
    aarch64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_arm64.tar.gz";
      hash = "sha256-KvtWGsmXze8+DPXrknqFtc7v8mea2QPm1Wq+tueAcoI=";
    };
  };
  src = sources.${stdenvNoCC.hostPlatform.system}
    or (throw "matcha-nightly: unsupported system ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "matcha-nightly";
  version = "nightly-30aa9eb";
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
