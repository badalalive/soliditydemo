const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Testing", function () {
  it("Should return the new greeting once it's changed", async function () {
    const Testing = await ethers.getContractFactory("Testing");
    const testing = await Testing.deploy("Hello, world!");
    await testing.deployed();

    expect(await testing.greet()).to.equal("Hello, world!");

    const setGreetingTx = await testing.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await testing.greet()).to.equal("Hola, mundo!");
  });
});
