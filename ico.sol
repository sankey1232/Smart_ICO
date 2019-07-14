// DigiCoin ICO(Initial Coin Offering)
pragma solidity ^0.5.1;

contract digicoin_ico {

    uint public digicoins_for_sale = 1000000;
    uint public inr_to_digicoin = 100;
    uint public total_digicoins_bought = 0;

    mapping(address => uint) equity_inr;
    mapping(address => uint) equity_digicoins;

    modifier can_buy_digicoins(uint inr_invested){
        require(inr_invested*inr_to_digicoin + total_digicoins_bought <= digicoins_for_sale);
        _;
    }

    function equity_in_inr(address investor) external view returns(uint){
        return equity_inr[investor];
    }

    function equity_in_digicoins(address investor) external view returns(uint){
        return equity_digicoins[investor];
    }

    function buy_digicoins(address investor, uint inr_invested) external
    can_buy_digicoins(inr_invested){
        uint digicoins_bought = inr_invested*inr_to_digicoin;
        equity_digicoins[investor] += digicoins_bought;
        equity_inr[investor] += equity_digicoins[investor]/inr_to_digicoin;
        total_digicoins_bought += digicoins_bought;
    }  

     function sell_digicoins(address investor, uint digicoins_to_sell) external
    {
       equity_digicoins[investor] -= digicoins_to_sell;
       equity_inr[investor] += equity_digicoins[investor]/inr_to_digicoin;
       total_digicoins_bought -= digicoins_to_sell; 
    }  

}


