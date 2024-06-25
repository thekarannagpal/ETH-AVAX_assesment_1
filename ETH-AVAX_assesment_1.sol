// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Universityteacher {
    struct Teacher {
        string name;
        string department;
        bool isActive;
    }

    mapping(uint => Teacher) private teacher; // Mapping of teacher IDs to teacher structs
    uint private teachercounter; // Counter for minister IDs
    address private owner; // Owner of the contract (admin)

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Function to add a new minister
    function addteacher(string memory _name, string memory _department) public onlyOwner {
        require(bytes(_name).length > 0, "teacher name must not be empty");
        require(bytes(_department).length > 0, "Teacher department must not be empty");
        teachercounter++;
        teacher[teachercounter] = Teacher(_name, _department, true);
    }

    // Function to get minister details
    function getTeacher(uint _id) public view returns (string memory, string memory, bool) {
        require(_id > 0 && _id <= teachercounter, "Teacher ID does not exist");
        Teacher memory t = teacher[_id];
        return (t.name, t.department, t.isActive);
    }

    // Function to update minister portfolio
    function updateDepartment(uint _id, string memory _newDepartment) public onlyOwner {
        require(_id > 0 && _id <= teachercounter, "Teacher ID does not exist");
        require(bytes(_newDepartment).length > 0, "New portfolio must not be empty");
        teacher[_id].department = _newDepartment;
    }

    // Function to deactivate a minister
    function deactivateteacher(uint _id) public onlyOwner {
        require(_id > 0 && _id <= teachercounter, "Teacher ID does not exist");
        teacher[_id].isActive = false;
    }

    // Function using assert to check a condition
    function testAssert(uint _id) public view {
        Teacher memory teacherMember = teacher[_id];
        // Using assert to ensure the minister's name is always not empty
        assert(bytes(teacherMember.name).length > 0);
    }

    // Function using require to check a condition
    function testRequire(uint _id) public view {
        // Using require to ensure the minister ID exists
        require(_id > 0 && _id <= teachercounter, "teacher ID does not exist");
    }

    // Function using revert to check a condition
    function testRevert(uint _id) public view {
        // Using revert to check if the minister ID does not exist
        if (_id == 0 || _id > teachercounter) {
            revert("Teacher ID does not exist");
        }
    }
}
