// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

contract HotelRoom {
    // enum status
    enum Status { Vacant, Occupied }
    // room status
    Status s_roomStatus;
    // event booked
    event Booked(address indexed who, uint256 indexed fee);
    // payable owner
    address payable s_owner;
    // constructor
    constructor() {
        s_owner = payable(msg.sender);
        s_roomStatus = Status.Vacant;
    }

    // modifier onlyWhenVacant
    modifier onlyWhenVacant() {
        require(s_roomStatus == Status.Vacant, "Room Occupied!");
        _;
    }

    // modifier correctPayment
    modifier correctPayment(uint256 fee) {
        require(msg.value >= fee, "No enough eth!");
        _;
    }

    function roomStatus() public view returns(Status) {
        return s_roomStatus;
    }

    function bookRoom() external payable onlyWhenVacant() correctPayment(2 ether) {
        s_roomStatus = Status.Occupied;
        emit Booked(msg.sender, msg.value);
    }
}