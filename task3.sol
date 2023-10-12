// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2;

contract SimpleContract {
    bool public allowed;
    uint256 public count;
    int256 public signedCount;
    address public owner;
    mapping(address => mapping(address => bool)) public allowance;
    string[] public errorMessages;

    struct Account {
        string firstName;
        string lastName;
        uint256 balance;
    }

    Account account;
    mapping(address => Account) public accountValues;
    Account[3] public admins;
    uint256 private index;

    constructor() {
        owner = msg.sender;
        errorMessages.push("it is not allowed");
        errorMessages.push("only owner");
        errorMessages.push("placeholder");
    }

    function setAllowed(bool _allowed) public {
        allowed = _allowed;
    }

    modifier isAllowed() {
        require(allowance[owner][msg.sender], errorMessages[0]);
        _;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, errorMessages[1]);
        _;
    }

    function onIncrement() public {
        ++count;
    }

    function increment(uint256 _increment) public isAllowed {
        count = count + _increment;
    }

    function signedIncrement(int256 _increment) public {
        signedCount = signedCount + _increment;
    }

    function assignAllowance(address _address) public onlyOwner {
        allowance[owner][_address] = true;
    }

    function assignValue(
        string memory _firstName,
        string memory _lastName,
        uint256 _balance
    ) public {
        account.firstName = _firstName;
        account.lastName = _lastName;
        account.balance = _balance;
    }

    function assignValue2(Account memory _account) public {
        account = _account;
    }

    function getAccount() public view returns (Account memory) {
        Account memory _account = account;
        return _account;
    }

    function assignAddressValues(Account memory _account) public {
        accountValues[msg.sender] = _account;
    }

    function addAdmin(Account memory admin) public {
        require(index < 3, "has no enough space");
        admins[index++] = admin;
    }

    function getAllAdmins() public view returns (Account[] memory) {
        Account[] memory _admins = new Account[](3);
        for (uint256 i = 0; i < 3; i++) {
            _admins[i] = admins[i];
        }

        return _admins;
    }
}