// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Console.sol";
import {GetterSetter} from "../src/GetterSetter.sol";

contract GetterSetterTest is Test {
    GetterSetter gs;
    string private constant DEFAULT_NAME = "Darren";
    function setUp() public {
        gs = new GetterSetter();
    }

    function test_getName() public {
        assertEq(gs.getName(), DEFAULT_NAME);
    }

    function test_setName() public {
        string memory newName = "A new name";
        gs.setName(newName);
        assertEq(gs.getName(), newName);
    }
}