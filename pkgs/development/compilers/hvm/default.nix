{ lib
, rustPlatform
, fetchCrate
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "hvm";
  version = "2.0.3";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-Z9ibOnlpgq9CRH61ys/eAy36etSPnWdA9FzGyeQdc08=";
  };

  cargoHash = "sha256-45SBU2+mEKU9A00AchLAzkqcCwNLhwbPGqaQGzbcg54=";

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk_11_0.frameworks.IOKit
  ];

  # tests are broken
  doCheck = false;

  # enable nightly features
  RUSTC_BOOTSTRAP = true;

  meta = with lib; {
    description = "A pure functional compile target that is lazy, non-garbage-collected, and parallel";
    mainProgram = "hvm";
    homepage = "https://github.com/higherorderco/hvm";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda ];
  };
}
