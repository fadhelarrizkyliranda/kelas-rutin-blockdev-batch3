// Import library Chai dan Hardhat
import { expect } from "chai";
import { ethers } from "hardhat";
import { SistemAkademik } from "../typechain-types";

describe("sistemAkademik", function () {
  let sistemAkademik: any;
  let owner;
  let user;

  // Sebelum setiap test dijalankan, deploy kontraknya dulu
  beforeEach(async function () {
    [owner, user] = await ethers.getSigners();
    const Akademik = await ethers.getContractFactory("sistemAkademik");
    sistemAkademik = await Akademik.deploy();
    await sistemAkademik.waitForDeployment();
  });

  it("seharusnya bisa melakukan pendaftaran mahasiswa", async function () {
    await sistemAkademik.enrollment(1234, "Budi", "Teknik Informatika");
    const data = await sistemAkademik.getStudent(1234);
    expect(data.nama).to.equal("Budi");
    expect(data.jurusan).to.equal("Teknik Informatika");
    expect(data.nim).to.equal(1234);
    expect(data.isActive).to.be.true;
  });

  it("seharusnya gagal jika NIM sudah terdaftar", async function () {
    await sistemAkademik.enrollment(1234, "Budi", "TI");
    await expect(
      sistemAkademik.enrollment(1234, "Asep", "SI")
    ).to.be.revertedWith("NIM sudah terdaftar!");
  });

  it("seharusnya menambahkan nilai mahasiswa", async function () {
    await sistemAkademik.enrollment(1234, "Budi", "TI");
    await sistemAkademik.addGrade(1234, 90);
    const data = await sistemAkademik.getStudent(1234);
    expect(data.nilai[0]).to.equal(90);
  });

  it("should revert if NIM already exists", async () => {
    await sistemAkademik.enrollment(1234, "Budi", "TKJ");
    await expect(
      sistemAkademik.enrollment(1234, "Budi", "TKJ")
    ).to.be.revertedWith("NIM sudah terdaftar!");
  });

  it("should revert if name is empty", async () => {
    await expect(sistemAkademik.enrollment(5678, "", "TKJ")).to.be.revertedWith(
      "Nama tidak boleh kosong!"
    );
  });
});
