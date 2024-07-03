//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
 * @title DecentralizedStableCoin
 * @author Georgi Totev
 * Collateral: Exogenous
 * Minting (Stability Mechanism): Decentralized (Algorithmic)
 * Value (Relative Stability): Anchored (Pegged to USD)
 * Collateral Type: Crypto
 *
* This is the contract meant to be owned by DSCEngine. It is a ERC20 token that can be minted and burned by the
DSCEngine smart contract.
 */

contract DecentralizeStableCoin is ERC20Burnable, Ownable {

    error DecentralizedStableCoin__MustBeMoreThanZero();
    error DecentralizedStableCoin__BurnAmountExceedsBalance();
    error DecentralizeStableCoin__NotZeroAddress();

    constructor()
        ERC20("DecentralizeStableCoin", "DSC")
        Ownable(address(this))
    {}

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);

        if (_amount <= 0) {
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        }
        if (balance < _amount){
            revert DecentralizedStableCoin__BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns(bool){
        if(_to == address(0)){
            revert DecentralizeStableCoin__NotZeroAddress();
        }

        if(_to <= address(0)){
            revert DecentralizedStableCoin__MustBeMoreThanZero();
        }
        _mint(_to, _amount);
        return true;
    }
}
