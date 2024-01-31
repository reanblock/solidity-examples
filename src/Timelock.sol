// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

// one can deposit ether into this contract but you must wait 
// 1 week before you can withdraw your funds

contract Timelock {
    // calling Math will add extra functions to the uint data type
    using Math for uint; // you can make a call like myUint.tryAdd(123)

    // amount of ether you deposited is saved in balances
    mapping(address => uint) public balances;

    // when you can withdraw is saved in lockTime
    mapping(address => uint) public lockTime;

    // deposit() function
    function deposit() external payable {
        balances[msg.sender] += msg.value;

        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    // increaseLockTime(_secondsToIncrease) function
    function increaseLockTime(uint _secondsToIncrease) external {
        (bool success, uint result) = lockTime[msg.sender].tryAdd(_secondsToIncrease);
        if (success) {
            // update the callers lockTime as requested!
            lockTime[msg.sender] = result;
        }
    }

    // withdraw() function
    // follow checks-effects-interactions! :) 
    function withdraw() external {
        // check that the sender has ether deposited in this contract in the mapping and the balance is >0
        require(balances[msg.sender] > 0, "Zero balance");
        // check that the now time is > the time saved in the lock time mapping
        require(block.timestamp >= lockTime[msg.sender], "Locked balance");

        // effects - update the balances
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        // interactions - send funds to caller
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "transfer failed");
    }

}