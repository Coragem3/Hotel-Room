pragma solidity ^0.6.0;

contract HotelRoom {

    enum Statuses { vacant, occupied }
    Statuses currentStatus;

    event occupy(address _occupant, uint _value);

    address payable public owner;

    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.vacant;

 }

    modifier onlyWhileVacant {
     require(currentStatus == Statuses.vacant, "Currently occupied.");
     _;

    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough Ether provided");
        
        _;
        }

        receive() external payable onlyWhileVacant costs(2 ether) {
               currentStatus = Statuses.occupied;
               owner.transfer(msg.value);
               emit occupy(msg.sender, msg.value);
        }

        }
