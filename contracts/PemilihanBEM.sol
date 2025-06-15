// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract PemilihanBEM {
    struct Kandidat {
        string nama;
        string visi;
        uint256 suara;
    }
    
    Kandidat[] public kandidat;
    mapping(address => bool) public sudahMemilih;
    mapping(address => bool) public pemilihTerdaftar;
    
    uint256 public waktuMulai;
    uint256 public waktuSelesai;
    address public admin;
    
    event VoteCasted(address indexed voter, uint256 kandidatIndex);
    event KandidatAdded(string nama);
    
    modifier onlyDuringVoting() {
        require(
            block.timestamp >= waktuMulai && 
            block.timestamp <= waktuSelesai, 
            "Voting belum dimulai atau sudah selesai"
        );
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Tidak memiliki akses ");
        _;
    }

    constructor(uint256 blockMulai, uint256 blockSelesai) {
        waktuMulai = blockMulai;
        waktuSelesai = blockSelesai;
        admin = msg.sender;
    }
    
    // TODO: Implementasikan add candidate function
    function addCandidate(string memory _nama, string memory _visi) public onlyAdmin {
        require(bytes(_nama).length > 0, "Nama kandidat tidak boleh kosong!");
        require(waktuMulai < waktuSelesai, "Pemilihan sudah selesai!");

        kandidat.push(Kandidat({nama: _nama, visi: _visi, suara: 0}));
        emit KandidatAdded(_nama);
    }

    function registerVoter() public {
        require(pemilihTerdaftar[msg.sender] == false, "Sudah terdaftar!");
        pemilihTerdaftar[msg.sender] = true;
        sudahMemilih[msg.sender] = false;
    }

    // TODO: Implementasikan vote function
    function vote(uint256 _indexKandidat ) public onlyDuringVoting {
        require(sudahMemilih[msg.sender] == false, "Tidak dapat memilih lebih dari satu kali!");
        require(_indexKandidat < kandidat.length,"Kandidat tidak tersedia!");
        require(waktuMulai < waktuSelesai, "Pemilihan sudah selesai!");
        
        kandidat[_indexKandidat].suara++;
        sudahMemilih[msg.sender] = true;

        emit VoteCasted(msg.sender, _indexKandidat);
    }
    
    // TODO: Implementasikan get results function
    function getResult() public view returns (Kandidat[] memory) {
        return kandidat;
    }
}