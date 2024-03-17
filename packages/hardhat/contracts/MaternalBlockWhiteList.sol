// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaternalBlockWhitelist {
    // Define enum for NFT categories
    enum NFTCategory { NewMum, BreastfeedingMum, Fathers, PregnantMum }

    // Define mapping to store whitelisted addresses
    mapping(address => bool) public whitelist;

    // Define mapping to store selected NFT category for each whitelisted address
    mapping(address => NFTCategory) public selectedCategory;

    // Define event for whitelisting status changes
    event Whitelisted(address indexed account, bool status);

    // Define event for NFT category selection
    event CategorySelected(address indexed account, NFTCategory category);

    // Whitelist an address
    function whitelistAddress(address _address) external {
        // Check if address is not already whitelisted
        require(!whitelist[_address], "Address is already whitelisted");

        // Whitelist the address
        whitelist[_address] = true;

        // Emit event
        emit Whitelisted(_address, true);
    }

    // Select NFT category for a whitelisted address
    function selectCategory(address _address, NFTCategory _category) external {
        // Check if address is whitelisted
        require(whitelist[_address], "Address is not whitelisted");

        // Set selected category
        selectedCategory[_address] = _category;

        // Emit event
        emit CategorySelected(_address, _category);
    }
}
