// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

contract Timelock {
    // overflow and underflow examples and preventions
    // one can deposit ether into this contract but you must wait 1 week before you can withdraw your funds

    // calling SafeMath will add extra functions to the uint data type

    // amount of ether you deposited is saved in balances

    // when you can withdraw is saved in lockTime

    // deposit() function

    // increaseLockTime(_secondsToIncrease) function

    // withdraw() function

        // check that the sender has ether deposited in this contract in the mapping and the balance is >0
        // check that the now time is > the time saved in the lock time mapping
}