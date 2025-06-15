// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract sistemAkademik {
    struct Mahasiswa {
        string nama;
        uint256 nim;
        string jurusan;
        uint256[] nilai;
        bool isActive;
    }
    
    mapping(uint256 => Mahasiswa) public mahasiswa;
    mapping(address => bool) public authorized;
    uint256[] public daftarNIM;
    
    event MahasiswaEnrolled(uint256 nim, string nama);
    event NilaiAdded(uint256 nim, uint256 nilai);
    
    modifier onlyAuthorized() {
        require(authorized[msg.sender], "Tidak memiliki akses");
        _;
    }
    
    constructor() {
        authorized[msg.sender] = true;
    }
    
    // TODO: Implementasikan enrollment function
    function enrollment(uint256 _nim, string memory _nama, string memory _jurusan) public onlyAuthorized {
        require(mahasiswa[_nim].nim != _nim, "NIM sudah terdaftar!");
        require(bytes(_nama).length > 0, "Nama tidak boleh kosong!");

        mahasiswa[_nim] = Mahasiswa ({
            nim : _nim,
            nama: _nama,
            jurusan: _jurusan,
            nilai: new uint256[](0),
            isActive: true
        });

        //Simpan NIM ke dalam daftar
        daftarNIM.push(_nim);

        emit MahasiswaEnrolled(_nim, _nama);
    }

    // TODO: Implementasikan add grade function
    function addGrade(uint256 _nim, uint256 _nilai) public onlyAuthorized {
        require(_nim == mahasiswa[_nim].nim, "NIM tersebut tidak ditemukan");
        require(mahasiswa[_nim].isActive, "Mahasiswa tidak aktif!");

        mahasiswa[_nim].nilai.push(_nilai);

        emit NilaiAdded(_nim, _nilai);
    }

    // TODO: Implementasikan get student info function
    function getStudent(uint256 _nim) public view returns (Mahasiswa memory) {
        require(_nim == mahasiswa[_nim].nim, "NIM tersebut tidak ditemukan");
        
        return mahasiswa[_nim];
    }
}