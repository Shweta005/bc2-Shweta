pragma solidity ^0.8.0;

import "./JPMToken.sol";

contract TokenSwap {
    string public name = "JPM Exchange";
    Token public token;
    uint public rate = 1;
    constructor(Token _token) public {
        token = _token;
    }

  //Events
   event TokenPurchased(
    address account,
    address token,
    uint amount,
    uint rate
   );

   event TokenSold(
    address account,
    address token,
    uint amount,
    uint rate
   );
    
    //Functions
    function buytokens() public payable{
        
        uint tokenAmt = msg.value * rate;
        require(token.balanceOf(address(this)) >= tokenAmt);
        //transfers tokens to buyers account
        token.transfer(msg.sender, tokenAmt);
        emit TokenPurchased(msg.sender,address(token), tokenAmt, rate);
    }

    function selltokens(uint _amt) public {
        require(token.balanceOf(msg.sender) >= _amt);
        //calculate the amount of ether 
        uint etherAmount = _amt / rate;
        token.transferFrom(msg.sender,address(this), _amt);
        //transfer ethers to sellers account
        payable(msg.sender).transfer(etherAmount);
        emit TokenSold(msg.sender, address(token), _amt, rate);
    }
}