// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Console.sol";
import {Timelock} from "../src/Timelock.sol";

contract HotelRoomTest is Test {
    Timelock tl;
    function setUp() public {
        tl = new Timelock();
    }
}