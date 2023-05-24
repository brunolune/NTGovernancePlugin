import {expect} from 'chai';
import {ethers} from 'hardhat';
import {BigNumber} from 'ethers';
import {SignerWithAddress} from '@nomiclabs/hardhat-ethers/signers';


export const tokenVotingInterface = new ethers.utils.Interface([
    'function initialize(address,tuple(uint8,uint32,uint32,uint64,uint256),address)',
    'function getVotingToken()',
  ]);