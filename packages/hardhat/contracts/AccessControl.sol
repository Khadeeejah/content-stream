// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MaternalBlockWhitelist.sol";

contract AccessControl {
    // Address of the MaternalBlockWhitelist contract
    address public whitelistContractAddress;

    // Mapping to store access permissions for each address
    mapping(address => bool) public accessGranted;

    // Event for access permission changes
    event AccessGranted(address indexed account, bool status);

    // Modifier to restrict access to whitelisted addresses with selected NFT category
    modifier onlyWhitelisted(address _address, MaternalBlockWhitelist.NFTCategory _category) {
        require(
            MaternalBlockWhitelist(whitelistContractAddress).whitelist(_address),
            "Address is not whitelisted"
        );
        require(
            MaternalBlockWhitelist(whitelistContractAddress).selectedCategory(_address) == _category,
            "Address has not selected the required NFT category"
        );
        _;
    }

    // Constructor to set the address of the MaternalBlockWhitelist contract
    constructor(address _whitelistContractAddress) {
        whitelistContractAddress = _whitelistContractAddress;
    }

    // Grant access to an address based on whitelist status and selected NFT category
    function grantAccess(address _address, MaternalBlockWhitelist.NFTCategory _category) external onlyWhitelisted(_address, _category) {
        // Grant access
        accessGranted[_address] = true;

        // Emit event
        emit AccessGranted(_address, true);
    }

    // Revoke access for an address
    function revokeAccess(address _address) external {
        // Require that the function caller has permission to revoke access
        require(msg.sender == owner(), "Only the contract owner can revoke access");

        // Revoke access
        accessGranted[_address] = false;

        // Emit event
        emit AccessGranted(_address, false);
    }

    // Function to check if an address has access
    function hasAccess(address _address) public view returns (bool) {
        return accessGranted[_address];
    }

    // Function to get the contract owner
    function owner() public view returns (address) {
        return msg.sender;
    }
}
