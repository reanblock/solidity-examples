// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.23;

contract GetterSetter {
    string private s_name;
    string private s_age;

    constructor() {
        s_name = "Darren";
    }

    function getName() external view returns (string memory name) {
        return s_name;
    }

    function setName(string calldata name) external {
        s_name = name;
    }
}