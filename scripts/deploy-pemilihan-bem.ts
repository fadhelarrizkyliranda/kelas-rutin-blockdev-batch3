// Script untuk men-deploy PemilihanBEM contract
import { ethers } from "hardhat";

async function main() {
  try {
    // Mendapatkan informasi jaringan
    const network = (await ethers.provider.getNetwork()).name;
    console.log(`Deploying PemilihanBEM to ${network} network...`);

    // Mendapatkan ContractFactory dari kompilasi Solidity
    const PemilihanBEM = await ethers.getContractFactory("PemilihanBEM");

    // Inisialisasi deployment
    console.log("Initiating deployment transaction...");
    const pemilihanBEM = await PemilihanBEM.deploy(
      1749859199000,
      1781395199000
    );

    // Tunggu sampai contract di-deploy ke jaringan
    console.log("Waiting for deployment transaction confirmation...");
    await pemilihanBEM.waitForDeployment();

    // Dapatkan alamat contract
    const contractAddress = await pemilihanBEM.getAddress();
    console.log(`PemilihanBEM deployed successfully to: ${contractAddress}`);

    // Informasi tambahan untuk Monad Testnet
    if (network === "monadTestnet") {
      console.log(`\nView your contract on Monad Testnet Explorer:`);
      console.log(
        `https://testnet.monadexplorer.com/address/${contractAddress}`
      );
    }

    return contractAddress;
  } catch (error) {
    console.error("Deployment failed with error:");
    console.error(error);
    process.exitCode = 1;
  }
}

// Pattern untuk menangani dan melaporkan error
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
