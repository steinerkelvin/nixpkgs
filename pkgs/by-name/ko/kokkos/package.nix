{ lib
, stdenv
, fetchFromGitHub
, gitUpdater
, cmake
, python3
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "kokkos";
  version = "4.3.00";

  src = fetchFromGitHub {
    owner = "kokkos";
    repo = "kokkos";
    rev = finalAttrs.version;
    hash = "sha256-0MMztgw+okZM/xr2vQucwkkT04iueQSlSQJ6MN/756I=";
  };

  nativeBuildInputs = [
    cmake
    python3
  ];

  cmakeFlags = [
    (lib.cmakeBool "Kokkos_ENABLE_TESTS" true)
  ];

  postPatch = ''
    patchShebangs .
  '';

  doCheck = true;
  passthru.updateScript = gitUpdater { };

  meta = with lib; {
    description = "C++ Performance Portability Programming EcoSystem";
    homepage = "https://github.com/kokkos/kokkos";
    license = with licenses; [ asl20-llvm ];
    maintainers = with maintainers; [ Madouura ];
    platforms = platforms.unix;
    broken = stdenv.isDarwin;
  };
})
