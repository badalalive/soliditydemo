//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

contract SafeMath {

    function safeAdd(uint a, uint b) internal pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }

    function safeSub(uint a, uint b) internal pure returns (uint c) {
        require(b <= a);
        c = a - b;
    }

//    function safeMul(uint a, uint b) internal pure returns (uint c) {
//        c = a * b;
//        require(a == 0 || c / a == b);
//    }
//
//    function safeDiv(uint a, uint b) internal pure returns (uint c) {
//        require(b > 0);
//        c = a / b;
//    }
}
contract ERC20Interface {
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract Token is ERC20Interface, SafeMath{

    string public token;
    string public symbol;
    uint256 public _totalSupply;
    uint public decimals;

    // A mapping is a key/value map. Here we store each account balance.
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint)) allowed;

    constructor () {
        token = "Delta token";
        symbol = "DELTA";
        _totalSupply = 100000;
        decimals = 0;
        balances[msg.sender] = _totalSupply;
    }
//    function totalSupply() public view returns (uint) {
//        return _totalSupply  - balances[address(0)];
//    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public  returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint tokens) public  returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public  returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

}
