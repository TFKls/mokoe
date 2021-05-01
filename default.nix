{ mkDerivation, base, bytestring, lens, random, stdenv, wreq }:
mkDerivation {
  pname = "mokoe";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base bytestring lens random wreq ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
