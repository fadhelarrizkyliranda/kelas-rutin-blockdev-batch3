# 🏗️ Kelas Rutin BlockDev Batch 3

This project is a learning and development sandbox for Batch 3 of the BlockDev routine class. It uses **[Hardhat](https://hardhat.org/)** as the Ethereum development environment for compiling, testing, and deploying smart contracts.

---

## 🚀 Tech Stack

- **Solidity**
- **Hardhat** `^2.24.3`
- **OpenZeppelin Contracts** `^5.3.0`
- **@nomicfoundation/hardhat-toolbox** `^5.0.0`

---

## 📦 Dependencies

| Package                            | Version | Description                             |
| ---------------------------------- | ------- | --------------------------------------- |
| `hardhat`                          | ^2.24.3 | Ethereum development framework          |
| `@nomicfoundation/hardhat-toolbox` | ^5.0.0  | Includes Ethers.js, Chai, Waffle, etc.  |
| `@openzeppelin/contracts`          | ^5.3.0  | Secure and community-reviewed contracts |
| `@adraffy/ens-normalize` (dev)     | 1.10.1  | ENS name normalization tool             |
| `source-map-support`               | 0.8.1   | Better stack traces in errors           |

---

## 📁 Project Structure

.
├── contracts/ # Solidity smart contracts
├── scripts/ # Deployment scripts
├── test/ # Unit tests
├── ignition/modules/ # Ignition config (deployment module)
├── hardhat.config.ts # Hardhat configuration file
└── README.md

---

## ⚙️ Getting Started

1. **Install dependencies**

   ```bash
   npm install

   ```

2. **Compile contracts**

   ```bash
   npx hardhat compile

   ```

3. **Run tests**

   ```bash
   npx hardhat test

   ```

4. **Deploy contract to local network**
   ```bash
   npx hardhat run scripts/deploy-taskmanager.ts --network hardhat
   ```
