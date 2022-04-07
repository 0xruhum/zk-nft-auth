compile:; npx circom ./nft.circom --r1cs --wasm --sym --c --wat --output ./out

witness:; node out/nft_js/generate_witness.js out/nft_js/nft.wasm input.json out/witness.wtns
