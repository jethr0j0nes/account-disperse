pragma solidity >=0.4.22 <0.6.0;
contract AddressDisperse {

    address admin;
    mapping(address => bool) addresses;

    constructor() 
    public
    payable 
    {
        admin = msg.sender;
    }

    function getBalance ()
        public
        view
        returns (uint256)
    {
        return address(this).balance;
    }

    function sendFunds(address payable[] memory _addresses) public {
        require(msg.sender == admin, "not admin");
        
        for(uint index=0; index<_addresses.length; index++){
            if(addresses[_addresses[index]] != true) {
                addresses[_addresses[index]] = true;
                _addresses[index].transfer(6000000000000000);
                
                
            }
        }
    }

    /** @dev Fall back function for recieving funds.
      */
    function ()
        external
        payable
    {
        
    }

    function withdrawFunds (uint _amount)
        public
        payable
    {
        // Require admin    
        require(msg.sender == admin, "not admin");
        // Require withdraw amount is greater than 0.
        require(_amount >= 0, "Withdraw amount less than zero.");
        // Require there are enough funds in the policy to cover withdrawal amount.
        require(
            _amount <= address(this).balance,
            "funds available to withdraw"
        );
        msg.sender.transfer(_amount);
    }
}
