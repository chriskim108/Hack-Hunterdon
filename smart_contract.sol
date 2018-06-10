pragma solidity ^0.4.18;

contract Owned{
    address owner;
    
    function Owned() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract Courses is Owned{
    struct stockInformation{
        uint numberOfMember;
        bytes16 nameOfStock;
        bytes16 buyPrice;
    }
    
    // Help us find a specific etherum address
    mapping (address => stockInformation) stockInformations;
    address[] public stockAccts;
    
    event stockInfo(
        bytes16 nameOfStock,
        bytes16 buyPrice,
        uint numberOfMember
    );
    
    function setStockInstruction(address _address, uint _numberOfMember, bytes16 _nameOfStock, bytes16 _buyPrice) onlyOwner public {
        var stock = stockInformations[_address];
        
        stock.numberOfMember = _numberOfMember;
        stock.nameOfStock = _nameOfStock;
        stock.buyPrice = _buyPrice;
        
        stockAccts.push(_address) -1;
        stockInfo(_nameOfStock, _buyPrice, _numberOfMember);
    }
    
    function getStocks() view public returns(address[]){
        return stockAccts;
    }
    
    function getStock(address _address) view public returns(uint, bytes16, bytes16) {
        return (stockInformations[_address].numberOfMember, stockInformations[_address].nameOfStock, stockInformations[_address].buyPrice);
    }
    
    function countStockData() view public returns(uint){
        return stockAccts.length; 
    }
}