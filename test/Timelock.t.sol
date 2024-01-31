// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Console.sol";
import {Timelock} from "../src/Timelock.sol";

abstract contract TimelockTestBase is Test {
    Timelock tl;
    address user1 = makeAddr("user1");
    function setUp() public virtual {
        tl = new Timelock();
    }
}

contract TimeLockTest is TimelockTestBase {
    function test_Deposit() public {
        hoax(user1, 10 ether);
        tl.deposit{value: 3 ether}();
        assertEq(tl.balances(user1), 3 ether);
        assertEq(tl.lockTime(user1), block.timestamp + 1 weeks);
    }   

    function test_WithdrawZeroBalance() public {
        vm.expectRevert("Zero balance");   
        vm.prank(user1);
        tl.withdraw();
    }
}

contract TimeLockDepositedTest is TimelockTestBase {
    function setUp() public override {
        super.setUp();
        hoax(user1, 10 ether);
        tl.deposit{value: 3 ether}();
    }

    function test_Deposit() public {
        vm.prank(user1);
        tl.deposit{value: 1 ether}();
        assertEq(tl.balances(user1), 4 ether);
        assertEq(tl.lockTime(user1), block.timestamp + 1 weeks);
    }   

     function test_increaseLockTime() public {
        uint preLockTime = tl.lockTime(user1);
        vm.prank(user1);
        tl.increaseLockTime(1 hours);
        assertEq(tl.lockTime(user1), preLockTime + 1 hours);
    }

    function test_WithdrawEarly() public {
        vm.expectRevert("Locked balance");
        vm.prank(user1);
        tl.withdraw();
    }

    function test_WithdrawSuccess() public {
        assertEq(address(user1).balance, 7 ether);
        uint unlockTime = tl.lockTime(user1);
        vm.warp(unlockTime);
        vm.prank(user1);
        tl.withdraw();
        assertEq(address(user1).balance, 10 ether);
    }
}