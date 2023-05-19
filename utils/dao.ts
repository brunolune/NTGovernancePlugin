import {BigNumber} from 'ethers';
import {ethers} from 'hardhat';
import {
  DAO,
  DAO__factory,
} from '../typechain-types';
import {deployWithProxy} from './proxy';
import {SignerWithAddress} from '@nomiclabs/hardhat-ethers/signers';

export const daoExampleURI = 'https://example.com';

export async function deployNewDAO(signer: SignerWithAddress): Promise<DAO> {
  const DAO = new DAO__factory(signer);
  const dao = await deployWithProxy<DAO>(DAO);

  await dao.initialize(
    '0x00',
    signer.address,
    ethers.constants.AddressZero,
    daoExampleURI
  );

  return dao;
}


