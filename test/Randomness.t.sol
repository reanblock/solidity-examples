// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Randomness} from "../src/Randomness.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Console.sol";

contract RandomnessTest is Test {
    Randomness rnd;
    function setUp() public {
        vm.roll(14);
        rnd = new Randomness{value: 1 ether}();
    }

    function test_rnd() public {
         assertEq(rnd.rngBad(), 56746034620459376767816395166660156684526387177822299409271508636501950091345);
    }

    function test_play() public {
        address attacker = makeAddr("attacker");

        // check balance of attacker is 0 ether
        // console.log("Attacker balance: ", address(attacker).balance);
        assertEq(address(attacker).balance, 0);

        // calc the number here
        uint guess = uint(keccak256(abi.encodePacked(
            block.timestamp,
            block.number, 
            block.difficulty)));

        // prank attacker
        vm.prank(attacker);
        // call play with the 'guess'
        rnd.play(guess);

        // check balance of attacker is now 1 ether
        // console.log("Attacker balance: ", address(attacker).balance);
        assertEq(address(attacker).balance, 1 ether);
    }
}