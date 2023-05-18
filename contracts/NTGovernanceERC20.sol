// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity 0.8.17;

//brownie imports
/* import "OpenZeppelin/openzeppelin-contracts-upgradeable@4.8.3/contracts/token/ERC20/ERC20Upgradeable.sol";
import "OpenZeppelin/openzeppelin-contracts-upgradeable@4.8.3/contracts/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "OpenZeppelin/openzeppelin-contracts-upgradeable@4.8.3/contracts/access/OwnableUpgradeable.sol";
import "OpenZeppelin/openzeppelin-contracts-upgradeable@4.8.3/contracts/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "OpenZeppelin/openzeppelin-contracts-upgradeable@4.8.3/contracts/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import "OpenZeppelin/openzeppelin-contracts-upgradeable@4.8.3/contracts/proxy/utils/Initializable.sol"; */

//hardhat imports
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

//import {IERC20PermitUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-IERC20PermitUpgradeable.sol";
//import {IERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import {IERC20MetadataUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
//import {ERC20VotesUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
//import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {ERC165Upgradeable} from "@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol";
import {IVotesUpgradeable} from "@openzeppelin/contracts-upgradeable/governance/utils/IVotesUpgradeable.sol";

import {DaoAuthorizableUpgradeable} from "@aragon/osx/core/plugin/dao-authorizable/DaoAuthorizableUpgradeable.sol";
import {IDAO} from "@aragon/osx/core/dao/IDAO.sol";

//import {IERC20MintableUpgradeable} from "@aragon/osx/token/ERC20/IERC20MintableUpgradeable.sol";

/// @title GovernanceERC20
/// @author Aragon Association
/// @notice An [OpenZeppelin `Votes`](https://docs.openzeppelin.com/contracts/4.x/api/governance#Votes) compatible [ERC-20](https://eips.ethereum.org/EIPS/eip-20) token that can be used for voting and is managed by a DAO.
contract NTGovernanceERC20 is
    Initializable,
    ERC165Upgradeable,
    ERC20Upgradeable,
    ERC20BurnableUpgradeable,
    ERC20PermitUpgradeable,
    ERC20VotesUpgradeable,
    DaoAuthorizableUpgradeable
{
    /// @notice The permission identifier to mint new tokens
    bytes32 public constant MINT_PERMISSION_ID = keccak256("MINT_PERMISSION");

    /// @notice The settings for the initial mint of the token.
    /// @param receivers The receivers of the tokens.
    /// @param amounts The amounts of tokens to be minted for each receiver.
    /// @dev The lengths of `receivers` and `amounts` must match.
    /* struct MintSettings {
        address[] receivers;
        uint256[] amounts;
    } */

    /// @notice Thrown if the number of receivers and amounts specified in the mint settings do not match.
    /// @param receiversArrayLength The length of the `receivers` array.
    /// @param amountsArrayLength The length of the `amounts` array.
    /* error MintSettingsArrayLengthMismatch(
        uint256 receiversArrayLength,
        uint256 amountsArrayLength
    ); */

    /// @notice Calls the initialize function.
    /// @param _dao The managing DAO.
    /// @param _name The name of the [ERC-20](https://eips.ethereum.org/EIPS/eip-20) governance token.
    /// @param _symbol The symbol of the [ERC-20](https://eips.ethereum.org/EIPS/eip-20) governance token.
    constructor(IDAO _dao, string memory _name, string memory _symbol) {
        initialize(_dao, _name, _symbol);
    }

    /// @notice Initializes the contract and mints tokens to a list of receivers.
    /// @param _dao The managing DAO.
    /// @param _name The name of the [ERC-20](https://eips.ethereum.org/EIPS/eip-20) governance token.
    /// @param _symbol The symbol of the [ERC-20](https://eips.ethereum.org/EIPS/eip-20) governance token.
    function initialize(
        IDAO _dao,
        string memory _name,
        string memory _symbol
    ) public initializer {
        // Check mint settings
        /*  if (_mintSettings.receivers.length != _mintSettings.amounts.length) {
            revert MintSettingsArrayLengthMismatch({
                receiversArrayLength: _mintSettings.receivers.length,
                amountsArrayLength: _mintSettings.amounts.length
            });
        } */

        __ERC20_init(_name, _symbol);
        __ERC20Permit_init(_name);
        __ERC20Burnable_init();
        __ERC20Votes_init();
        __DaoAuthorizableUpgradeable_init(_dao);

        /* for (uint256 i; i < _mintSettings.receivers.length; ) {
            _mint(_mintSettings.receivers[i], _mintSettings.amounts[i]);

            unchecked {
                ++i;
            }
        } */
    }

    /// @notice Checks if this or the parent contract supports an interface by its ID.
    /// @param _interfaceId The ID of the interface.
    /// @return Returns `true` if the interface is supported.
    /* function supportsInterface(
        bytes4 _interfaceId
    ) public view virtual override returns (bool) {
        return
            _interfaceId == type(IERC20Upgradeable).interfaceId ||
            _interfaceId == type(IERC20PermitUpgradeable).interfaceId ||
            _interfaceId == type(IERC20MetadataUpgradeable).interfaceId ||
            _interfaceId == type(IVotesUpgradeable).interfaceId ||
            _interfaceId == type(IERC20MintableUpgradeable).interfaceId ||
            super.supportsInterface(_interfaceId);
    } */

    /// @notice Mints tokens to an address.
    /// @param to The address receiving the tokens.
    /// @param amount The amount of tokens to be minted.
    function mint(
        address to,
        uint256 amount
    ) external auth(MINT_PERMISSION_ID) {
        _mint(to, amount);
    }

    // The following functions are overrides required by Solidity.

    function _mint(
        address to,
        uint256 amount
    ) internal override(ERC20Upgradeable, ERC20VotesUpgradeable) {
        super._mint(to, amount);
    }

    function _burn(
        address account,
        uint256 amount
    ) internal override(ERC20Upgradeable, ERC20VotesUpgradeable) {
        super._burn(account, amount);
    }

    // https://forum.openzeppelin.com/t/self-delegation-in-erc20votes/17501/12?u=novaknole
    /// @inheritdoc ERC20VotesUpgradeable
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20Upgradeable, ERC20VotesUpgradeable) {
        super._afterTokenTransfer(from, to, amount);

        // Automatically turn on delegation on mint/transfer but only for the first time.
        if (
            to != address(0) &&
            numCheckpoints(to) == 0 &&
            delegates(to) == address(0)
        ) {
            _delegate(to, to);
        }
    }

    /// @notice Overriding the _transfer function to make the token non-transferable (NTToken)
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal pure override(ERC20Upgradeable) {
        revert("This token is non-transferable");
    }
}
