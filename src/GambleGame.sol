// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

contract GambleGame {
    mapping(address => uint) public players;
    uint256 lastValue;
    uint8 constant WINS_IN_ROW = 9;

    constructor() payable {}

    function play(bool _guess) external payable {
        require(msg.value == 1 ether, "Send 1 ETH");

        uint256 value = uint256(blockhash(block.number - 1));
        require(lastValue != value, "One round per block!");
        lastValue = value;

        uint256 random = value % 2;
        bool answer = random == 1 ? true : false;

        if (answer == _guess) {
            players[msg.sender]++;

            if(players[msg.sender] == WINS_IN_ROW) {
                (bool sent, ) = msg.sender.call{value: address(this).balance}("");
                require(sent, "Failed to send ETH");
                players[msg.sender] = 0;
            }
        } else {
            players[msg.sender] = 0;
        }
    }
}