// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

contract Randomness {
    constructor() payable {}

    function play(uint guess) external {
        uint number = uint(keccak256(abi.encodePacked(block.timestamp, block.number, block.difficulty)));

        if(guess == number) {
            (bool sent, ) = msg.sender.call{value: address(this).balance}("");
            require(sent, "unable to to send ETH");
        }
    }
    function rngBad() public view returns(uint256 num) {
        return uint(keccak256(abi.encodePacked(  block.timestamp, 
                                                 block.difficulty, 
                                                 block.number)));
    }
}