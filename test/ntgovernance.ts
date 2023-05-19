import {SignerWithAddress} from '@nomiclabs/hardhat-ethers/signers';
import {ethers} from 'hardhat';
import {expect} from 'chai';

import {
    NTGovernanceERC20,
    NTGovernanceERC20__factory,
    DAO
} from '../typechain-types'

import { deployNewDAO } from '../utils/dao';

let signers: SignerWithAddress[];
let dao: DAO;
let token: NTGovernanceERC20;
let TokenFactory: NTGovernanceERC20__factory

describe("Non-Transferable Token", () => {
    before(async () => {
        signers = await ethers.getSigners();
        dao = await deployNewDAO(signers[0]);
        console.log("dao address =",dao.address)
    })
    describe("Token Deployment", async () => {
        it("Successfully deploy the token contract", async () => {
            TokenFactory = await ethers.getContractFactory(
                'NTGovernanceERC20',
                signers[0]
            ) as NTGovernanceERC20__factory;
    
            token = await TokenFactory.deploy(
                dao.address,
                "Non-Transferable Token",
                "NTT",
            );

            await Promise.all([
                dao.grant(
                  token.address,
                  signers[0].address,
                  ethers.utils.id('MINT_PERMISSION')
                )
              ]);
            expect(await token.name()).to.be.equal("Non-Transferable Token")
            expect(await token.symbol()).to.be.equal("NTT")
        });
    })
    describe("Token Minting", async () => {
        before(async () => {
            await token.mint(signers[0].address,ethers.BigNumber.from(1000000000000000000n))
            await token.mint(signers[1].address,ethers.BigNumber.from(1000000000000000000n))
            await token.mint(signers[2].address,ethers.BigNumber.from(1000000000000000000n))
            await token.mint(signers[3].address,ethers.BigNumber.from(1000000000000000000n))
        })
        it("successfully mints tokens", async () => {
            expect(await token.balanceOf(signers[0].address)).to.be.equal(ethers.BigNumber.from(1000000000000000000n))
            expect(await token.balanceOf(signers[1].address)).to.be.equal(ethers.BigNumber.from(1000000000000000000n))
            expect(await token.balanceOf(signers[2].address)).to.be.equal(ethers.BigNumber.from(1000000000000000000n))
            expect(await token.balanceOf(signers[3].address)).to.be.equal(ethers.BigNumber.from(1000000000000000000n))
        })
        it("successfully burns tokens", async () => {
            await token.connect(signers[3]).burn(ethers.BigNumber.from(400000000000000000n))
            expect(await token.balanceOf(signers[3].address)).to.be.equal(ethers.BigNumber.from(600000000000000000n))
        })

        it("denies transferring of tokens", async () => {
            await expect(token.connect(signers[2]).transfer(signers[0].address, 100)).to.be.revertedWith("This token is non-transferable")
        })
        it("successfully returns the supply", async () => {
            expect(await token.totalSupply()).to.be.equal(ethers.BigNumber.from(3600000000000000000n))
        })
    });

});