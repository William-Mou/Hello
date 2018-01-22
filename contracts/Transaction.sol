pragma solidity ^0.4.17;

contract Transaction {
    address employee;
    address employer;
    uint balances;
    uint create_time;
    uint base_wage;
    uint payables;
    uint expire = 100;
    uint working_hours;
    uint ETH_to_TWD_100 = 300;
    bool ended = false;
    bool usaged = false;
    
    function Transaction(address new_employee, uint new_working_hours ,uint new_base_wage)payable public{
        if (ended == true) return;
        employee = new_employee;
        employer = msg.sender;
        working_hours = new_working_hours;
        base_wage=new_base_wage;
        balances=msg.value;
        if (working_hours >= 2) payables = (working_hours-2)*base_wage*266+working_hours*233*base_wage;
        else payables = working_hours*233*base_wage;
        if (payables>=balances/ETH_to_TWD_100) usaged=true;
        else return;
        create_time=now;
    }
    function add_more(uint new_working_hours )payable public{
        if (ended == true) return;
        working_hours+=new_working_hours;
        balances+=msg.value;
        if (working_hours >= 2) payables = (working_hours-2)*base_wage*266+working_hours*233*base_wage;
        else payables = working_hours*233*base_wage;
        if (payables>=balances/ETH_to_TWD_100) usaged=true;
        create_time=now;
    }
    
    function is_expire() public returns(uint){
        if (ended == true) return;
        if ((now - create_time)> (expire * 1 seconds)) {
            ended = false;
            return (now);
        }
        else {
            ended = true;
            return (now);
        }
    }
    function test()public returns(uint){
        return 15;
    }
    
    function collectMoney() public {
        is_expire();
        if (msg.sender==employee && usaged == true && ended==true ) employee.transfer(balances);
        else reserve();
    }
}

[{"adress new_employee":"0xca35b7d915458ef540ade6068dfe2f44e8fa733c" , "uint new_working_hours": 1 , "uint new_base_wage" : 140 }]
0xca35b7d915458ef540ade6068dfe2f44e8fa733c