pragma solidity ^0.4.25;

contract Stock_Market {
    
    uint32 stockAmount;
    string stockName;
    string purchase_result;
    
    mapping (string => uint32) private currentStocks;

    
    function buy_stock(string target_stock_name, uint32 target_stock_amount) payable returns (string){
        if (validStock(target_stock_name) && stockAmount >= target_stock_amount) {
            stockAmount = stockAmount - target_stock_amount;
            currentStocks[target_stock_name] += target_stock_amount;
            purchase_result = "Successful purchase!";
            return purchase_result;
        }
        purchase_result = "Unsuccessful purchase!";
        return purchase_result;
    }
    
    function sell_stock(string target_stock_name, uint32 target_stock_amount) payable returns (string) {
        if (validStock(target_stock_name) && target_stock_amount <= currentStocks[target_stock_name]) {
            stockAmount = stockAmount + target_stock_amount;
            currentStocks[target_stock_name] -= target_stock_amount;
            purchase_result = "Successful sale!";
            return purchase_result;
        }
        purchase_result = "Unsuccessful sale!";
        return purchase_result;
    }
    
    constructor(string _stockName, uint32 _stockAmount) public payable{
        stockName = _stockName;
        stockAmount = _stockAmount;
	}
	
	function ownedStockAmounts(string stockName, address currentUserAddress) public view returns (uint32) {
        if (validStock(stockName) == false && address(this) == currentUserAddress) throw;
        return currentStocks[stockName];
    }
    
    function validStock(string _stockName) public view returns (bool) {
        bool valid = false;
        if (keccak256(stockName) == keccak256(_stockName)) {
            valid = true;
        }
        return valid;
    }
    
    function printStockName() public view returns (string) {
        return stockName;
    }
    
    function printStockAmount() public view returns (uint32) {
        return stockAmount;
    }
}