// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Universityteacher {
    struct Teacher {
        string name;
        string department;
        bool isActive;
    }

    mapping(uint => Teacher) private teacher; // Mapping of teacher IDs to teacher structs
    uint private teachercounter; // Counter for teacher IDs
    address private owner; // Owner of the contract (admin)

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Function to add a new tecaher
    function addteacher(string memory _name, string memory _department) public onlyOwner {
        require(bytes(_name).length > 0, "teacher name must not be empty");
        require(bytes(_department).length > 0, "Teacher department must not be empty");
        teachercounter++;
        teacher[teachercounter] = Teacher(_name, _department, true);
    }

    // Function to get teacher details
    function getTeacher(uint _id) public view returns (string memory, string memory, bool) {
        require(_id > 0 && _id <= teachercounter, "Teacher ID does not exist");
        Teacher memory t = teacher[_id];
        return (t.name, t.department, t.isActive);
    }

    // Function to update teacher portfolio
    function updateDepartment(uint _id, string memory _newDepartment) public onlyOwner {
        require(_id > 0 && _id <= teachercounter, "Teacher ID does not exist");
        require(bytes(_newDepartment).length > 0, "New portfolio must not be empty");
        teacher[_id].department = _newDepartment;
    }

    // Function to deactivate a teacher
    function deactivateteacher(uint _id) public onlyOwner {
        require(_id > 0 && _id <= teachercounter, "Teacher ID does not exist");
        teacher[_id].isActive = false;
    }

    // Function using assert to check a condition
    function testAssert(uint _id) public view {
        Teacher memory teacherMember = teacher[_id];
        // Using assert to ensure the teacher's name is always not empty
        assert(bytes(teacherMember.name).length > 0);
    }

    // Function using require to check a condition
    function testRequire(uint _id) public view {
        // Using require to ensure the teacher ID exists
        require(_id > 0 && _id <= teachercounter, "teacher ID does not exist");
    }

    // Function using revert to check a condition
    function testRevert(uint _id) public view {
        // Using revert to check if the teacher ID does not exist
        if (_id == 0 || _id > teachercounter) {
            revert("Teacher ID does not exist");
        }
    }
}
