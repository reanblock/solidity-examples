// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Console.sol";
import {HotelRoom} from "../src/HotelRoom.sol";

contract HotelRoomTest is Test {
    HotelRoom room;
    event Booked(address indexed who, uint256 indexed fee);

    enum Status { Vacant, Occupied }

    function setUp() public virtual {
        room = new HotelRoom();
    }
}

contract HotelRoomVacantTest is HotelRoomTest {
     function test_bookRoomVacant() public {
        assertEq(address(room).balance, 0);
        // 1. call expectEmit(checkTopic1, checkTopic2, checkTopic3, checkData)
        vm.expectEmit(true, true, false, false);
        // 2. emit the expected event in the test
        emit Booked(address(this), 2 ether);
        // 3. call the function that should emit that event!
        room.bookRoom{value: 2 ether}();
        assertEq(address(room).balance, 2 ether);
    }

    function test_bookRoomIncorrectFee() public {
        vm.expectRevert("No enough eth!");
        room.bookRoom{value: 1 ether}();
    }
}

contract HotelRoomOccupiedTest is HotelRoomTest {
    function setUp() public override {
        super.setUp();
        room.bookRoom{value: 2 ether}();
    }

    function test_bookRoomWhenOccupied() public {
        // console.log("Status.Vacant: ", uint(Status.Vacant)); // 0
        // console.log("Status.Occupied: ", uint(Status.Occupied)); // 1

        // room should be in an Occupied state
        assertEq(uint(room.roomStatus()),  uint(Status.Occupied));
        vm.expectRevert("Room Occupied!");
        room.bookRoom();
    }
}