pragma solidity 0.8.23;

import {console} from "forge-std/Console.sol";

contract AddressBook {
    mapping(address => address[]) s_addressBook;
    mapping(address => mapping(address => string)) s_alias;

    function addAddress(address newAddress, string calldata alia) external {
        s_addressBook[msg.sender].push(newAddress);
        s_alias[msg.sender][newAddress] = alia;
    }

    function getAddressBook() public view returns (address[] memory addresses) {
        return s_addressBook[msg.sender];
    }

    function getAlias(address addr) public view returns (string memory alia) {
        return s_alias[msg.sender][addr];
    }

    function removeAddress(address addr) public {
        uint256 length = s_addressBook[msg.sender].length;
        for(uint i; i < length; i++) {
            address fnd = s_addressBook[msg.sender][i];
            if(fnd == addr) {
                if(1 < length && i < length -1) {
                    // overwrite the last address in the slot we want to delete
                    s_addressBook[msg.sender][i] = s_addressBook[msg.sender][length -1];
                }
                // always pop off the last element which also updates the length prroperty
                s_addressBook[msg.sender].pop();
                delete s_alias[msg.sender][addr];

                break;
            }
        }
    }
}