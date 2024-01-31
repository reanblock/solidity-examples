// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Console.sol";
import {AddressBook} from "../src/AddressBook.sol";

contract AddressBookTest is Test {
    AddressBook addressBook;
    address addr1 = address(0xBe63983a1C7769301B41F57b91a727615e6A8d85);
    address addr2 = address(0x793f8f6dBe3bd0a97324aCc1364A7F2416AC9B28);
    address addr3 = address(0xeDe027972E137A471bf1bF83497080Aa447Ccf82);
    address user = makeAddr("user");
    string alia1 = "Mum";
    string alia2 = "Friend";
    string alia3 = "AnotherFriend";

    function setUp() public {
        addressBook = new AddressBook();
        vm.startPrank(user);
        addressBook.addAddress(addr1, alia1);
        addressBook.addAddress(addr2, alia2);
        vm.stopPrank();
    }

    function test_getAddressBook() public {
        vm.prank(user);
        address[] memory addresses = addressBook.getAddressBook();
        assertEq(addresses[0], addr1);
    }

    function test_getAlias() public {
        vm.prank(user);
        assertEq(addressBook.getAlias(addr1), alia1);
    }

    function test_addAddress() public {
        vm.prank(user);
        uint256 len = addressBook.getAddressBook().length;
        assertEq(len, 2);

        vm.startPrank(user);
        addressBook.addAddress(addr3, alia3);

        len = addressBook.getAddressBook().length;
        assertEq(len, 3);
    }

    function test_removeAddress() public {
        vm.startPrank(user);
        uint256 prevLen = addressBook.getAddressBook().length;
        assertGt(prevLen, 1);
        assertEq(addressBook.getAlias(addr1), alia1);
        
        addressBook.removeAddress(addr1);
        uint256 len = addressBook.getAddressBook().length;
        assertEq(len, prevLen -1);
        assertEq(addressBook.getAlias(addr1), "");
    }
 }