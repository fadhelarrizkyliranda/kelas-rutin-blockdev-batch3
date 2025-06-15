// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract digitalWalletCampus {
    mapping(address => uint256) public balances;
    address public admin;
    
    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);
    
    constructor() {
        admin = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == admin, "Hanya Admin yang diizinkan!");
        _;
    }
    
    function deposit() public payable {
        require(msg.value > 0, "Amount harus lebih dari 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    
    // TODO: Implementasikan withdraw function
    function withdraw(uint _amount) public payable {
        //Validasi saldo harus lebih dari 0
        require(_amount > 0, "Amount harus lebih dari 0");

        //Validasi saldo cukup untuk withdraw
        require(balances[msg.sender] >= _amount, "Tidak dapat melakukan Withdraw karena saldo tidak cukup!");

        //Pengurangan saldo
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    // TODO: Implementasikan transfer function
    function transfer (address _to, uint _amount) public {
        //Validasi saldo harus lebih dari 0
        require(_amount > 0, "Amount harus lebih dari 0");

        //Validasi cukup untuk withdraw
        require(balances[msg.sender] >= _amount, "Tidak dapat melakukan Transfer karena saldo tidak cukup!");

        //Validasi tidak boleh transfer ke wallet sendiri
        require(_to != msg.sender, "Tidak boleh mentransfer ke alamat yang sama dengan pengirim!");

        //Transfer saldo
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }

    // TODO: Tambahkan access control
    function emergencyWithdraw(address _wallet, uint _amount) public onlyOwner {
        //Validasi saldo harus lebih dari 0
        require(_amount > 0, "Amount harus lebih dari 0");

        //Validasi cukup untuk withdraw
        require(balances[_wallet] >= _amount, "Tidak dapat melakukan Withdraw karena saldo tidak cukup!");

        balances[_wallet] -= _amount;
        balances[admin] += _amount;

        emit Withdrawal(msg.sender, _amount);
    }
    
}