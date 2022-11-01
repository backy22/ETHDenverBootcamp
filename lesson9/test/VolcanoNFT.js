const {
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");

describe("VolcanoNFT", function () {
  async function deployVolcanoNFTFixture() {
    const [owner, otherAccount] = await ethers.getSigners();

    const VolcanoNFT = await ethers.getContractFactory("VolcanoNFT");
    const volcanonft = await VolcanoNFT.deploy();

    return { volcanonft, owner, otherAccount };
  }

  describe("Operate", function() {
    it("Should mint the NFT", async function () {
      const { volcanonft, owner } = await loadFixture(deployVolcanoNFTFixture);
      await volcanonft.safeMint(owner.address);
      expect(await volcanonft.balanceOf(owner.address)).to.equal(1);
    })

    it("Should transfer the NFT", async function() {
      const { volcanonft, owner, otherAccount } = await loadFixture(deployVolcanoNFTFixture);
      await volcanonft.safeMint(owner.address);
      await volcanonft.transfer(owner.address, otherAccount.address, 0);
      expect(await volcanonft.balanceOf(otherAccount.address)).to.equal(1);
    })
  })

});
