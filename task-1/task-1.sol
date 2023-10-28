// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;


struct Tenant {
    address tenantAddress; 
    string tenantName; 
    string tenantAddressInfo; 
}


struct LeaseContract {
    address ownerAddress; 
    uint256 leaseStartDate; 
    uint256 leaseEndDate; 
    Tenant tenant; 
    bool isActive; 
}

contract LeaseContractManager {

    LeaseContract[] public leaseContracts;

    function createLeaseContract(
        address _ownerAddress,
        uint256 _leaseStartDate,
        uint256 _leaseEndDate,
        address _tenantAddress,
        string memory _tenantName,
        string memory _tenantAddressInfo
    ) public {
        Tenant memory newTenant = Tenant({
            tenantAddress: _tenantAddress,
            tenantName: _tenantName,
            tenantAddressInfo: _tenantAddressInfo
        });

        LeaseContract memory newLeaseContract = LeaseContract({
            ownerAddress: _ownerAddress,
            leaseStartDate: _leaseStartDate,
            leaseEndDate: _leaseEndDate,
            tenant: newTenant,
            isActive: true
        });

        leaseContracts.push(newLeaseContract);
    }

    function endLeaseContract(uint256 contractIndex) public {
        require(contractIndex < leaseContracts.length, "Invalid operation");
        leaseContracts[contractIndex].isActive = false;
    }

    function getLeaseContract(uint256 contractIndex) public view returns (LeaseContract memory) {
        require(contractIndex < leaseContracts.length, "Invalid operation");
        return leaseContracts[contractIndex];
    }
}
