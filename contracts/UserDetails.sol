//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract UserDetails {

    struct Student {
        string  name;
        uint class;
    }

    mapping(uint => Student)  data;

    function setNameClass(uint _rollno, string memory _name, uint _class) public {
     data[_rollno] = Student(_name,_class);
    }

    function StudentData(uint rollno) public view returns(string memory  name, uint class) {
        return (data[rollno].name, data[rollno].class);
    }


}
