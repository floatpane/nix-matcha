{ stdenvNoCC, fetchurl, lib }:
let
  sources = {
    x86_64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_amd64.tar.gz";
      hash = "sha256-GB4vyHBsk8wn0XN/wnhWtTzmo5OhfK9rmXlKJVlAn1o=";
    };
    aarch64-darwin = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_darwin_arm64.tar.gz";
      hash = "sha256-B4ZNVgzvmnTtPp2sBKEhxXcq9Sj/X0ulgdWB/TUz87s=";
    };
    x86_64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_amd64.tar.gz";
      hash = "sha256-dUigc0GXtK39dg7GGCnRdd4UgNSV5JJBX0xPAHiQbjs=";
    };
    aarch64-linux = {
      url = "https://github.com/floatpane/matcha/releases/download/nightlyv0/matcha_nightly_linux_arm64.tar.gz";
      hash = "sha256-JsBfrOeE77vEvPE6vu6PAYWafJmryxd+rZBKv/AJeQw=";
    };
  };
  src = sources.${stdenvNoCC.hostPlatform.system}
    or (throw "matcha-nightly: unsupported system ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "matcha-nightly";
  version = "nightly-ddf3a5e";
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
