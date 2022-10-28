const {
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");

describe("VolcanoCoin", function () {
  async function deployVolcanoCoinFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const VolcanoCoin = await ethers.getContractFactory("VolcanoCoin");
    const volcanocoin = await VolcanoCoin.deploy();

    return { volcanocoin, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should set 1000 for the total supply", async function() {
      const { volcanocoin } = await loadFixture(deployVolcanoCoinFixture);
      expect(await volcanocoin.totalSupply()).to.equal(10000);
    })
  });

  describe("Operate", function() {
    it("Should increase in 1000", async function () {
      const { volcanocoin } = await loadFixture(deployVolcanoCoinFixture);
      await volcanocoin.changeTotalSupply()
      expect(await volcanocoin.totalSupply()).to.equal(11000);
    })

    it("Shouldn't increase by non-owner", async function() {
      const { volcanocoin, otherAccount } = await loadFixture(deployVolcanoCoinFixture)
      await expect(volcanocoin.connect(otherAccount).changeTotalSupply()).to.be.reverted;
    })
  })

});
