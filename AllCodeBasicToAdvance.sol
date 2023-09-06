
// navvatc tokens

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface INav {
    function name()external view returns(string memory);
    function symbol()external view returns (string memory);
    function transfer(address _to,uint _amount)external returns(bool);
    function totalSupply()external view returns(uint);
    function balanceOf()external view returns(uint);
}

contract NavCoin is INav{
    string private Coinname;
    string private CoinSymbol;
    uint private CoinTotalSupply;
    address private owner;

    constructor(string memory _name, string memory _symbol, uint _totalSupply){
        Coinname=_name;
        CoinSymbol=_symbol;
        CoinTotalSupply=_totalSupply;
        owner=msg.sender;
        balances[owner]+=_totalSupply;
    }



    mapping (address=>uint)private balances;

     function name()external view returns(string memory){
         return Coinname;
     }
    function symbol()external view returns (string memory){
        return CoinSymbol;
    }

    function transfer(address _to,uint _amount)external returns(bool){
        
        uint oldbalance=balances[msg.sender];
        
        require(_amount<=balances[msg.sender], "Insufficient balance");
        balances[msg.sender]-=_amount;
        balances[_to]+=_amount;

        if(oldbalance==balances[msg.sender]){
            return false;
        }else return true;



    }
    function totalSupply()external view returns(uint){
        return CoinTotalSupply;
    }
    function balanceOf()external view returns(uint){
      return balances[msg.sender];
    }
}


// create a tandori nonshop token
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface INav {
    function name()external view returns(string memory);
    function symbol()external view returns (string memory);
    function transfer(address _to,uint _amount)external returns(bool);
    function totalSupply()external view returns(uint);
    function balanceOf()external view returns(uint);
}

contract NavCoin is INav{
    string private Coinname;
    string private CoinSymbol;
    uint private CoinTotalSupply;
    address private owner;

    constructor(string memory _name, string memory _symbol, uint _totalSupply){
        Coinname=_name;
        CoinSymbol=_symbol;
        CoinTotalSupply=_totalSupply;
        owner=msg.sender;
        balances[owner]+=_totalSupply;
    }



    mapping (address=>uint)private balances;

     function name()external view returns(string memory){
         return Coinname;
     }
    function symbol()external view returns (string memory){
        return CoinSymbol;
    }

    function transfer(address _to,uint _amount)external returns(bool){
        
        uint oldbalance=balances[msg.sender];
        
        require(_amount<=balances[msg.sender], "Insufficient balance");
        balances[msg.sender]-=_amount;
        balances[_to]+=_amount;

        if(oldbalance==balances[msg.sender]){
            return false;
        }else return true;



    }
    function totalSupply()external view returns(uint){
        return CoinTotalSupply;
    }
    function balanceOf()external view returns(uint){
      return balances[msg.sender];
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


/*
    *************************************************************************
                             Library in solidity
    *************************************************************************
    */
// library is used when we implement some extra functionlity to the code
library basicOperation{
    function Add(uint a,uint b) public pure returns(uint){
        return a+b;
    }

    function Sub(uint a,uint b) public pure returns(uint){
        if(a > b ){
            return a - b;
        }
        else{
             return b - a;
        }
    }

    function Divide(uint a,uint b) public pure returns(uint){
        return a/b;
    }

    function Modulas(uint a,uint b) public pure returns(uint){
        return a%b;
    }

    function Multiply(uint a,uint b) public pure returns(uint){
        return a*b;
    }
}

contract callCulater{
    function Addition(uint a, uint b) public pure returns (uint) {
        uint sum = basicOperation.Add(a, b);
        return sum;
    }
    function Subtraction(uint a, uint b) public pure returns (uint) {
        uint sub = basicOperation.Sub(a, b);
        return sub;
    }
    function Multiply(uint a, uint b) public pure returns (uint) {
        uint sum = basicOperation.Multiply(a, b);
        return sum;
    }
    function Divide(uint a, uint b) public pure returns (uint) {
        uint sub = basicOperation.Divide(a, b);
        return sub;
    }
    function Modulas(uint a, uint b) public pure returns (uint) {
        uint sub = basicOperation.Modulas(a, b);
        return sub;
    }
}

contract Wallets {
    struct PERSONS {
        uint256 id;
        address payable depositAddress;
        string name;
        uint256 amount;
    }

    mapping(address => uint256) public balance;

    PERSONS[] public personArray;
    PERSONS singlePerson;

    function registerUser(
        uint256 _id,
        string memory _name,
        address payable _address
    ) public payable {
        singlePerson = PERSONS(_id, payable(_address), _name, 10 ether);
        personArray.push(singlePerson);

        byDefaultDeposit(_id);
        balance[personArray[_id].depositAddress] = 10 ether;
    }

    function byDefaultDeposit(uint _id) public{
        payable(personArray[_id].depositAddress).transfer(10 ether);
    }

    function returnSingleUser(address _address)
        private
        view
        returns (PERSONS memory)
    {
        // return personArray[id];
    }

    function withdrawAmount(uint _from,uint _to,uint256 _amount) public payable {
        uint256 amount = _amount * 1000000000000000000;
        // require(balance[personArray[0].depositAddress] >= amount, "Insufficient balance");
        payable(personArray[_from].depositAddress).transfer(amount);
        balance[personArray[0].depositAddress] -= amount;

        personArray[0].amount -= _amount;
        personArray[1].amount += _amount;
    }

    receive() external payable {}

    fallback() external payable {}
}

// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

contract Dami_Wallet{
    // address public WalletOwner= msg.sender;

    mapping(address =>uint) public balanceOf;
    event balanceDetails(address receipent,uint amount);

    function depositAmount() public payable{
        balanceOf[msg.sender] +=msg.value;
        emit balanceDetails(msg.sender,msg.value);

    }
    function getBalance()public view returns (uint){
        return balanceOf[msg.sender];
    }
    function contractBalcne()public view returns(uint){
        return address(this).balance;
    }
         function withdraw(address _addr, uint _amount) public{
             require(balanceOf[msg.sender]>=_amount,"low Balance");
             balanceOf[msg.sender] -= _amount;
             balanceOf[_addr] +=_amount;
            //  payable(_addr).transfer(_amount);
             emit balanceDetails(_addr,_amount);
         }
}


contract aliSherWallet{
    
    // accounts (address => balance)
    mapping (address => uint) public Accounts;
    mapping (address => bool) private DataBase;

    ////////////////////////////////////////////////////////////////
    // fallback() payable external{}
    // receive() payable external{}

    event Trx(address From,address To,uint Amount);

    modifier checkBalance(uint _amount){
        require (Accounts[msg.sender] >= _amount,"Poor You");
        _;
    }
    modifier Exist(address _addr) {
        require(DataBase[_addr],"Account != Exist");
        _;
    }
    /////////////////////////////////////////////////////////////////

    function createAccount() public {
        require(!DataBase[msg.sender],"Account Already Exist");
        Accounts[msg.sender] = 0 ether;
        DataBase[msg.sender] = true;
    }

    function Deposit() public payable{
        Accounts[msg.sender] += msg.value;
        emit Trx(msg.sender,msg.sender, msg.value);
    }

    // Internal Transfer of Assets
    function InternalTransfer(address _addr,uint _amount) public checkBalance(_amount) Exist(_addr){
        Accounts[msg.sender] -= _amount;
        Accounts[_addr] += _amount;
        emit Trx(msg.sender,_addr,_amount);
    }

    // External Transfer of Assets
    function Withdraw(address payable _addr,uint _amount) public checkBalance(_amount){
        assert(_addr != address(0)); // No gas refund for 0x0000000000000000000000000000000000000000
        if(_addr.send(_amount)){
            Accounts[msg.sender] -= _amount;
            emit Trx(msg.sender,_addr, _amount);
        }else revert("Not Sent");
    }

}



// multi wallets 
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Wallet{
    
    // accounts (address => balance)
    mapping (address => uint) public Accounts;
    mapping (address => bool) private DataBase;

    ////////////////////////////////////////////////////////////////
    // fallback() payable external{}
    // receive() payable external{}

    event Trx(address From,address To,uint Amount);

    modifier checkBalance(uint _amount){
        require (Accounts[msg.sender] >= _amount,"Poor You");
        _;
    }
    modifier Exist(address _addr) {
        require(DataBase[_addr],"Account != Exist");
        _;
    }
    /////////////////////////////////////////////////////////////////

    function createAccount() public {
        require(!DataBase[msg.sender],"Account Already Exist");
        Accounts[msg.sender] = 0 ether;
        DataBase[msg.sender] = true;
    }

    function Deposit() public payable{
        Accounts[msg.sender] += msg.value;
        emit Trx(msg.sender,msg.sender, msg.value);
    }

    // Internal Transfer of Assets
    function InternalTransfer(address _addr,uint _amount) public checkBalance(_amount) Exist(_addr){
        Accounts[msg.sender] -= _amount;
        Accounts[_addr] += _amount;
        emit Trx(msg.sender,_addr,_amount);
    }

    // External Transfer of Assets
    function Withdraw(address payable _addr,uint _amount) public checkBalance(_amount){
        assert(_addr != address(0)); // No gas refund for 0x0000000000000000000000000000000000000000
        if(_addr.send(_amount)){
            Accounts[msg.sender] -= _amount;
            emit Trx(msg.sender,_addr, _amount);
        }else revert("Not Sent");
    }

}



// task to create wallets
contract Wallets {
    address owner = msg.sender;
    mapping(address => uint256) balance;

    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    function checkBalance() public view returns (uint256) {
        return balance[msg.sender];
    }

    function withdraw(uint256 _amount) public {
        uint256 amount = _amount * 1000000000000000000;
        require(
            balance[msg.sender] >= amount && owner == msg.sender,
            "Insufficient balance"
        );
        balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}

// Wednesday 7/6/2023
// mini digitall wallets

contract CreateWallets {
    struct Person {
        address payable recieveAddress;
        string name;
        uint256 amount;
    }

    Person public p1;
    function depositAmount() public payable virtual {}
}

contract person1 is CreateWallets {
    function setUserDetails(address _depositAddress, string memory _name)
        public
    {
        p1.recieveAddress = payable(_depositAddress);
        p1.name = _name;
        p1.amount = 0;
    }

    function depositAmount() public payable override {
        p1.recieveAddress.transfer(msg.value);
        p1.amount += msg.value;
    }

    function withdrawAmount(address _address) public payable {
        payable(_address).transfer(msg.value);  
        p1.amount -= msg.value;
    }

    fallback() external payable {}
    receive() external payable {}
}

// Wednesday 7/6/2023
// transfer keyword
contract SenderEither {
    address payable reciver;
   

    event info(address recievedAddress, uint256 amount);

    constructor(address _address) {
        reciver = payable(_address);
    }

    function transferEthertoAddress() public payable returns (string memory) {
        reciver.transfer(msg.value);
        emit info(reciver, msg.value);
        return "amount sended";
    }
}

// in this we used inheratance and super keyword

contract Donation {
    event info(string func, uint256 donationAmount);

    function sendDonation() public payable virtual {
        emit info("DonationContract", msg.value);
    }

    fallback() external payable {}

    receive() external payable {}
}

contract SadkaContract is Donation {
    function sendDonation() public payable virtual override {
        emit info("sadkaContract", msg.value);
        super.sendDonation();
    }
}

contract ZakatContract is Donation {
    function sendDonation() public payable virtual override {
        emit info("zakatContract", msg.value);
        super.sendDonation();
    }
}

contract charityContract is ZakatContract, SadkaContract {
    function sendDonation()
        public
        payable
        override(ZakatContract, SadkaContract)
    {
        emit info("zakatContract", msg.value);
        super.sendDonation();
    }
}

//Safe Math Interface

contract SafeMath {
    function safeAdd(uint256 a, uint256 b) public pure returns (uint256 c) {
        c = a + b;
        require(c >= a);
    }

    function safeSub(uint256 a, uint256 b) public pure returns (uint256 c) {
        require(b <= a);
        c = a - b;
    }

    function safeMul(uint256 a, uint256 b) public pure returns (uint256 c) {
        c = a * b;
        require(a == 0 || c / a == b);
    }

    function safeDiv(uint256 a, uint256 b) public pure returns (uint256 c) {
        require(b > 0);
        c = a / b;
    }
}

//ERC Token Standard #20 Interface

abstract contract ERC20Interface {
    function totalSupply() public virtual returns (uint256 _totalSupply);

    function balanceOf(address tokenOwner)
        public
        virtual
        returns (uint256 balance);

    function allowance(address tokenOwner, address spender)
        public
        virtual
        returns (uint256 remaining);

    function transfer(address to, uint256 tokens)
        public
        virtual
        returns (bool success);

    function approve(address spender, uint256 tokens)
        public
        virtual
        returns (bool success);

    function transferFrom(
        address from,
        address to,
        uint256 tokens
    ) public virtual returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint256 tokens
    );
}

//Contract function to receive approval and execute function in one call

contract ApproveAndCallFallBack {
    function receiveApproval(
        address from,
        uint256 tokens,
        address token,
        bytes memory data
    ) public {}
}

//Actual token contract

contract QKCToken is ERC20Interface, SafeMath {
    string public symbol;
    string public name;
    uint8 public decimals;
    uint256 public _totalSupply;
    address public YOUR_METAMASK_WALLET_ADDRESS;
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    constructor() {
        symbol = "hM";
        name = "HM coin";
        decimals = 2;
        _totalSupply = 100000;
        balances[YOUR_METAMASK_WALLET_ADDRESS] = _totalSupply;
        emit Transfer(address(0), YOUR_METAMASK_WALLET_ADDRESS, _totalSupply);
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply - balances[address(0)];
    }

    function balanceOf(address tokenOwner)
        public
        view
        override
        returns (uint256 balance)
    {
        return balances[tokenOwner];
    }

    function transfer(address to, uint256 tokens)
        public
        override
        returns (bool success)
    {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint256 tokens)
        public
        override
        returns (bool success)
    {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokens
    ) public override returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender)
        public
        view
        override
        returns (uint256 remaining)
    {
        return allowed[tokenOwner][spender];
    }

    function approveAndCall(
        address spender,
        uint256 tokens,
        bytes memory data
    ) public payable returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        ApproveAndCallFallBack(spender).receiveApproval(
            msg.sender,
            tokens,
            address(this),
            data
        );
        return true;
    }

    fallback() external payable {}

    receive() external payable {}
}

//  token new project //////////////////////////////////////////////////////////////////////////////////

// pragma solidity 0.8.19;

// //Safe Math Interface

// contract SafeMath {

//     function safeAdd(uint a, uint b) public pure returns (uint c) {
//         c = a + b;
//         require(c >= a);
//     }

//     function safeSub(uint a, uint b) public pure returns (uint c) {
//         require(b <= a);
//         c = a - b;
//     }

//     function safeMul(uint a, uint b) public pure returns (uint c) {
//         c = a * b;
//         require(a == 0 || c / a == b);
//     }

//     function safeDiv(uint a, uint b) public pure returns (uint c) {
//         require(b > 0);
//         c = a / b;
//     }
// }

// //ERC Token Standard #20 Interface

// contract ERC20Interface {
//     function totalSupply() public  returns (uint);
//     function balanceOf(address tokenOwner) public  returns (uint balance);
//     function allowance(address tokenOwner, address spender) public  returns (uint remaining);
//     function transfer(address to, uint tokens) public returns (bool success);
//     function approve(address spender, uint tokens) public returns (bool success);
//     function transferFrom(address from, address to, uint tokens) public returns (bool success);

//     event Transfer(address indexed from, address indexed to, uint tokens);
//     event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
// }

// //Contract function to receive approval and execute function in one call

// contract ApproveAndCallFallBack {
//     function receiveApproval(address from, uint256 tokens, address token, bytes data) public;
// }

// //Actual token contract

// contract QKCToken is ERC20Interface, SafeMath {
//     string public symbol;
//     string public  name;
//     uint8 public decimals;
//     uint public _totalSupply;
//     address public YOUR_METAMASK_WALLET_ADDRESS;
//     mapping(address => uint) balances;
//     mapping(address => mapping(address => uint)) allowed;

//     constructor() public {
//         symbol = "hM";
//         name = "HM coin";
//         decimals = 2;
//         _totalSupply = 100000;
//         balances[YOUR_METAMASK_WALLET_ADDRESS] = _totalSupply;
//         emit Transfer(address(0), YOUR_METAMASK_WALLET_ADDRESS, _totalSupply);
//     }

//     function totalSupply() public  returns (uint) {
//         return _totalSupply  - balances[address(0)];
//     }

//     function balanceOf(address tokenOwner) public  returns (uint balance) {
//         return balances[tokenOwner];
//     }

//     function transfer(address to, uint tokens) public returns (bool success) {
//         balances[msg.sender] = safeSub(balances[msg.sender], tokens);
//         balances[to] = safeAdd(balances[to], tokens);
//         emit Transfer(msg.sender, to, tokens);
//         return true;
//     }

//     function approve(address spender, uint tokens) public returns (bool success) {
//         allowed[msg.sender][spender] = tokens;
//         emit Approval(msg.sender, spender, tokens);
//         return true;
//     }

//     function transferFrom(address from, address to, uint tokens) public returns (bool success) {
//         balances[from] = safeSub(balances[from], tokens);
//         allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
//         balances[to] = safeAdd(balances[to], tokens);
//         emit Transfer(from, to, tokens);
//         return true;
//     }

//     function allowance(address tokenOwner, address spender) public  returns (uint remaining) {
//         return allowed[tokenOwner][spender];
//     }

//     function approveAndCall(address spender, uint tokens, bytes memory data) public returns (bool success) {
//         allowed[msg.sender][spender] = tokens;
//         emit Approval(msg.sender, spender, tokens);
//         ApproveAndCallFallBack(spender).receiveApproval(msg.sender, tokens, this, data);
//         return true;
//     }

//     // function () public payable {
//         // revert();
//     // }
// }
// Wednesday 7/5/2023
// all about inheratance

contract Vichle {
    event Info(string contractName, string message);

    function startEngine() public virtual { 
        emit Info("vichle", "vicheles engine is started");
    }

    function stopEngine() public virtual {
        emit Info("vichle", "vicheles engine is stopped");
    }
}

contract Car is Vichle {
    function startEngine() public virtual override {
        emit Info("Car", "vicheles engine is started");
    }

    function stopEngine() public virtual override {
        emit Info("Car", "vicheles engine is stopped");
    }
}

contract Truck is Vichle {
    function startEngine() public virtual override {
        emit Info("vichle", "vicheles engine is started");
    }

    function stopEngine() public virtual override {
        emit Info("Car", "vicheles engine is stopped");
    }
}

contract SUV is Car, Truck {
    function startEngine() public override(Car, Truck) {
        emit Info("SUV", "vicheles engine is started");
        super.startEngine();
    }

    function stopEngine() public override(Car, Truck) {
        emit Info("SUV", "vicheles engine is stopped");
        super.stopEngine();
    }
}

// how to override the state variables in a child contract
// ===> we used contracter
contract A {
    string name = "contract A";

    function getName() public view virtual returns (string memory _name) {
        _name = name;
    }
}

contract B is A {
    // we used constructer to override the states
    constructor() {
        name = "Contract B";
    }

    function getName() public view override returns (string memory _name) {
        _name = string(abi.encodePacked(super.getName(), "child B"));
    }
}

contract Donation {

    event info(string func, uint256 donationAmount);

    function sendDonation() public payable virtual {
        emit info("DonationContract", msg.value);
    }

    fallback() external payable {}

    receive() external payable {}
}

contract SadkaContract is Donation {
    function sendDonation() public payable override {
        emit info("sadkaContract", msg.value);
    }
}

contract ZakatContract is Donation {
    function sendDonation() public payable override {
        emit info("zakatContract", msg.value);
    }
}


// Wednesday 7/5/2023
// all about inheratance

contract Vichle {
    event Info(string contractName, string message);

    function startEngine() public virtual {
        emit Info("vichle", "vicheles engine is started");
    }

    function stopEngine() public virtual {
        emit Info("vichle", "vicheles engine is stopped");
    }
}

contract Car is Vichle {
    function startEngine() public virtual override {
        emit Info("Car", "vicheles engine is started");
    }

    function stopEngine() public virtual override {
        emit Info("Car", "vicheles engine is stopped");
    }
}

contract Truck is Vichle {
    function startEngine() public virtual override {
        emit Info("vichle", "vicheles engine is started");
    }

    function stopEngine() public virtual override {
        emit Info("Car", "vicheles engine is stopped");
    }
}

contract SUV is Car, Truck {
    function startEngine() public override(Car, Truck) {
        emit Info("SUV", "vicheles engine is started");
        super.startEngine();
    }

    function stopEngine() public override(Car, Truck) {
        emit Info("SUV", "vicheles engine is stopped");
        super.stopEngine();
    }
}

// how to override the state variables in a child contract
// ===> we used contracter
contract A {
    string name = "contract A";

    function getName() public view virtual returns (string memory _name) {
        _name = name;
    }
}

contract B is A {
    // we used constructer to override the states
    constructor() {
        name = "Contract B";
    }

    function getName() public view override returns (string memory _name) {
        _name = string(abi.encodePacked(super.getName(), "child B"));
    }
}

// Tuesday 7/4/2023
// all about inheratance

contract Donation2 {
    event info(string func, uint256 donationAmount, bytes data);

    function Zakat() external payable virtual {
        emit info("zakat", msg.value, msg.data);
    }

    function Sadka() public payable virtual {
        emit info("sadka", msg.value, msg.data);
    }

    // function userDonate(uint256 _number) public {
    //     if (_number == 0) {
    //         Sadka();
    //     }
    //     if (_number == 1) {
    //         Zakat();
    //     }
    // }

    fallback() external payable {}

    receive() external payable {}
}

contract ZakatContract is Donation2{
    function Zakat() public payable override {
        emit info("zakatContract is called", msg.value, msg.data);
    }
}

contract SadkaContract is Donation2{
    function Sadka() public payable override {
        emit info("sadkaContract is called", msg.value, msg.data);
    }
}


contract Parent {
    string  name;
    uint256  age;
    constructor(uint _age,string memory _name){
        age = _age;
        name = _name;
    }
    

    function checkNameAndAge() public virtual returns(uint,string memory) {
        return (age,name);
    }
}

contract Child1 is Parent(56,'ahmad') {
    
}

// in this we can accept arrays as input and output in functuion
contract ArrayReturn {
    // uint256[] public marks;

    // function entermarks(uint256 _mark) public {
    //     marks.push(_mark);
    // }

    // function getMarks() public view returns (uint256[] memory _mark) {
    //     _mark = marks;
    // }

    //struct is created here
    struct Record {
        uint256 rollNo;
        bool isEligible;
        string name;
    }
    // struct instance is created
    Record public stu1;

    // function with multiple inputs
    function multipleInputs(
        uint256 _rollno,
        bool _isEligible,
        string memory _name
    ) public {
        stu1.rollNo = _rollno;
        stu1.isEligible = _isEligible;
        stu1.name = _name;
    }

    // function which call the multiple input functions
    function callMultipleFunction() public payable {
        multipleInputs(67, true, "raheel");
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

/*
            fallback and recieve function
    1)Fallback:
                ==> fallback excute in that time when we call function and the function is not available
                ==> we can make its visibilty external
                ==> it have no name
                ==> we can not pass any arguments in there
                ==> not return anything
                ==> it can be define one time per contract
                ==>its main use is directly send the eth to contract.
    note:
            it gives two things.
                data(bytes format data) and either
            ==> we marked as payable
    syntex:
            fallback() external payable {}
   
    
    2)recive:
            All thing have same but there are little difference which are given
                ==>it will take only either
                ==>and its is mendatory payable the recieve function
    note:
            if we send data(hexadecimal format) then it will show that error
                ==>'Fallback' function is not defined
    syntex:
            receive() external payable {}          
*/

/*
    scenario:
        if there have both fallback,recive function used within contract
            ==>if we send only ether,so it will be accepted by recieve function.
            ==>if we send data and ether combine,so it will be accepted by fallback function
*/
contract fallBackAndRecieveContract {
    event log(string func, address send, uint256 val, bytes data);

    //declared the fallBack function
    /*in this we can recieve either but where we recive bytes data.
            ==> go to deploy section and deploy the function
            ==> in bottom you will see low level interection section
            ==> enter the data in hexadecimal format like 0x4536323,0x342354
            ==> the data will be sended
    */

    fallback() external payable {
        //  msg.value ===> show sended either
        //  msg.sender ==> who send ether
        //  msg.data ==> show sended data
        emit log("fallback", msg.sender, msg.value, msg.data);
    }

    // recieve function
    receive() external payable {
        //  msg.value ===> show sended either
        //  msg.sender ==> who send ether
        emit log(
            "recieve",
            msg.sender,
            msg.value,
            "recieve can not accept data"
        );
    }

    // function checkBal() public view returns (uint256) {
    //     return address(this).balance;
    // }
}


// donaatain function
contract Donation {
    event info(string func, uint256 donationAmount, bytes data);

    function Zakat() public payable {
        emit info("zakat", msg.value, msg.data);
    }

    function Sadka() public payable {
        emit info("sadka", msg.value, msg.data);
    }

    function userDonate(uint256 _number) public {
        if (_number == 1) {
            Sadka();
        }
        if (_number == 2) {
            Zakat();
        }
    }

    fallback() external payable {}

    receive() external payable {}
}

contract Election21 {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
        string details;
    }

    struct Voterss {
        uint256 id;
        string name;
        uint256 age;
        bool voted;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voterss) public voters;

    uint256 public candidatesCount;
    uint256 public votersCount;

    string candidate;

    event votedEvent(uint256 indexed _candidateId);

    function addCandidate(
        uint256 _candidateId,
        string memory _name,
        string memory _details
    ) public {
        require(msg.sender == owner, "you are not the owner");
        candidatesCount++;
        candidates[_candidateId] = Candidate(_candidateId, _name, 0, _details);
    }

    function addVoter(
        address _address,
        uint256 _voterId,
        string memory _name,
        uint256 _age
    ) public {
        require(msg.sender == owner, "you are not the owner");
        votersCount++;
        voters[_address] = Voterss(_voterId, _name, _age, false);
    }

    function vote(uint256 _candidateId) public {
        require(_candidateId == candidates[_candidateId].id, "you");
        require(!voters[msg.sender].voted, "you have already voted");
        require(voters[msg.sender].age >= 18, "you have lowest age");
        candidates[_candidateId].voteCount++;
        voters[msg.sender].voted = true;

        emit votedEvent(_candidateId);
    }
}

contract TotalSupplyContract {
    uint256 public TotalSupply;
    string public tokenName;
    string public tokenSymbols;
    address public owner;

    constructor(
        uint256 _totalSupply,
        string memory _tokenName,
        string memory _tokenSymbol
    ) {
        owner = msg.sender;
        TotalSupply = _totalSupply;
        tokenName = _tokenName;
        tokenName = _tokenSymbol;
    }

    function changeTokenInfo(
        uint256 _totalSupply,
        string memory _tokenName,
        string memory _tokenSymbol
    ) public {
        require(msg.sender == owner, "not a valid owner");
        TotalSupply = _totalSupply;
        tokenName = _tokenName;
        tokenName = _tokenSymbol;
    }
}


// modifier
contract modifierParent {
    address owner;
    uint256 public mobilePrice = 20000;

    constructor() {
        owner = msg.sender;
    }

    modifier ownerModifier() {
        require(msg.sender == owner, "not a valid owner");
        _;
    }

    function priceIncrement(uint256 _price)
        public
        virtual
        CheckPrice(_price)
        ownerModifier
        returns (uint256)
    {
        mobilePrice = _price;
        return mobilePrice;
    }

    modifier CheckPrice(uint256 _price) virtual {
        require(
            mobilePrice < _price,
            "price should be greater than mobilePrice"
        );
        _;
    }
}

contract modifierChild is modifierParent {
    function priceIncrement(uint256 _price)
        public
        override
        ownerModifier
        CheckPrice(_price)
        returns (uint256)
    {
        mobilePrice = _price;
        return mobilePrice;
    }

    modifier CheckPrice(uint256 _price) override {
        require(
            mobilePrice < _price,
            "price should be greater than mobilePrice"
        );
        _;
    }
}

// vote casting using modifiers
contract Election20 {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
        string details;
    }

    Candidate can1 = Candidate(1, "ahmad", 0, "pti");

    struct Voterss {
        uint256 id;
        string name;
        uint256 age;
        bool voted;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voterss) public voters;

    uint256 public candidatesCount;
    uint256 public votersCount;

    event votedEvent(uint256 indexed _candidateId);

    function addCandidate(
        uint256 _candidateId,
        string memory _name,
        string memory _details
    ) public {
        candidatesCount++;
        candidates[_candidateId] = Candidate(_candidateId, _name, 0, _details);
    }

    function addVoter(
        uint256 _voterId,
        string memory _name,
        uint256 _age
    ) public {
        votersCount++;
        voters[msg.sender] = Voterss(_voterId, _name, _age, false);
    }

    modifier AgeCheck() {
        require(voters[msg.sender].age >= 18, "you have lowest age");
        _;
    }
    modifier voteStatus() {
        require(!voters[msg.sender].voted, "you have already voted");
        _;
    }
    modifier candiateExistOrNot(uint256 _candidateId) {
        require(
            _candidateId == candidates[_candidateId].id,
            "the candaite Id does not exist"
        );
        _;
    }

    function vote(uint256 _candidateId)
        public
        voteStatus
        AgeCheck
        candiateExistOrNot(_candidateId)
    {
        candidates[_candidateId].voteCount++;
        voters[msg.sender].voted = true;

        emit votedEvent(_candidateId);
    }
}

// modifier
contract modifierContract {
    address owner;
    uint256 public mobilePrice = 20000;

    constructor() {
        owner = msg.sender;
    }

    modifier ownerModifier() {
        require(msg.sender == owner, "not a valid owner");
        _;
    }
    modifier CheckPrice(uint256 _price) {
        require(
            mobilePrice < _price,
            "price should be greater than mobilePrice"
        );
        _;
    }

    function priceIncrement(uint256 _price)
        public
        ownerModifier
        CheckPrice(_price)
        returns (uint256)
    {
        mobilePrice = _price;
        return mobilePrice;
    }
}

contract EmployeeDetails {
    address public owner;

    constructor() {
        owner = msg.sender;
        require(msg.sender == owner, "you are not a valid owner");
    }

    struct EMP {
        uint256 id;
        string name;
        uint256 age;
        string add;
    }
    mapping(uint256 => EMP) public employees;

    EMP public employee1;

    function setdetails(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _add
    ) public view {
        EMP memory emp1;
        emp1 = employee1;
        emp1 = EMP({id: _id, name: _name, age: _age, add: _add});
    }

    function getdetails(uint256 _id) public view returns (string memory name) {
        name = employees[_id].name;
    }

    function getdetails1(uint256 _id)
        public
        view
        returns (string memory name, string memory add)
    {
        name = getdetails(_id);
        add = employees[_id].add;
    }
}

// destructuring in function
contract returnThreeValues {
    struct Emp {
        uint256 ID;
        string NAME;
        uint256 AGE;
        string CITY;
    }

    mapping(address => Emp) emp1;

    function addEmployee(
        uint256 _id,
        string memory _name,
        uint256 _age,
        string memory _city
    ) public {
        emp1[msg.sender].ID = _id;
        emp1[msg.sender].NAME = _name;
        emp1[msg.sender].AGE = _age;
        emp1[msg.sender].CITY = _city;
    }

    function getLimitedDetails(address _add)
        public
        view
        returns (uint256 id, string memory name)
    {
        id = emp1[_add].ID;
        name = emp1[_add].NAME;
    }

    function getAllDetails(address _add)
        public
        view
        returns (
            uint256 id,
            string memory name,
            uint256 age,
            string memory city
        )
    {
        // this is destructure in functiom
        (id, name) = getLimitedDetails(_add);
        age = emp1[_add].AGE;
        city = emp1[_add].CITY;
    }
}

contract EachValue {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
        string details;
    }

    mapping(address => Candidate) candidate;

    function addCandidate(
        uint256 _candidateId,
        string memory _name,
        uint256 _voteCount,
        string memory _details
    ) public {
        candidate[msg.sender].id = _candidateId;
        candidate[msg.sender].name = _name;
        candidate[msg.sender].voteCount = _voteCount;
        candidate[msg.sender].details = _details;
    }

    function getStruct(address _add)
        public
        view
        returns (
            uint256 _id,
            string memory _name,
            uint256 _voteCount,
            string memory _details
        )
    {
        _id = candidate[_add].id;
        _name = candidate[_add].name;
        _voteCount = candidate[_add].voteCount;
        _details = candidate[_add].details;
    }
}

contract requireAndRevert {
    uint256 number = 8;
    uint256 mynumber;

    function setNumber() public {
        require(number > 10, "the number is less than 10");
        number = 15;
    }

    function testRevert(uint256 _num) public {
        if (_num <= 10) {
            revert("input must be greater than 10");
        } else {
            mynumber = _num;
        }
    }

    // )
    //c
    error DefaultError(uint256 totalBalance, uint256 totalWithdraw);

    function ErrorHandle(uint256 _withdraw) public pure {
        uint256 contractBalance = 1000;
        if (contractBalance > _withdraw) {
            revert DefaultError(contractBalance, _withdraw);
        }
    }

    error stringLog(string state, uint256 age);

    function checkStringError(uint256 _age) public pure {
        string memory stateName = "pakistan";
        if (_age > 18) {
            revert stringLog(stateName, _age);
        }
    }
}

contract arrayPlaying {
    string[] public names;
    string public message;
    uint256[] mark;

    function pushOperation(string memory _i) public {
        if (names.length <= 2) {
            message = "you are allow to enter more values";
            names.push(_i);
        } else {
            message = "you have exceed the array size";
        }
    }

    function popOperation() public {
        names.pop();
    }

    function getEachMark(uint256 _int) public view returns (uint256) {
        return mark[_int];
    }

    function getEachNames(uint256 _int) public view returns (string memory) {
        return names[_int];
    }
}

contract simpleContract {
    int256 public negativeNumber = -20;
    uint256 public positiveNumber = 20;
    bool public boolean = false;
    string public name = "ahmad";
    address public myAddress;
    bytes1 public bytedata = 0x14;
    int256 public constant MY_VALUE = 34;
    uint256 public myEther = 1 ether;
    uint256 public myWei = 1 wei;

    function setValues(
        int256 _negativeNumber,
        uint256 _positiveNumber,
        bool _boolean,
        string memory _name,
        bytes1 _byte
    ) public {
        negativeNumber = _negativeNumber;
        positiveNumber = _positiveNumber;
        boolean = _boolean;
        bytedata = _byte;
        name = _name;
    }
}

contract student {
    string public name;
    uint256 public rollNo;
    address public addressStore;
    uint256[] public mark;

    function setName(string memory _name) public {
        name = _name;
    }

    function setRollNo(uint256 _roll) public {
        rollNo = _roll;
    }

    function setAddress(address _add) public {
        addressStore = _add;
    }

    function setMark(uint256 _mark) public {
        mark[1] = _mark;
    }
}

contract Election1 {
    string public message;

    //name ===> votts
    mapping(string => uint256) voterNameAndMarks;

    //Id ===> age
    mapping(uint256 => uint256) voterIdAndAge;

    // it will set the voter age based on id
    function setAge(uint256 _id, uint256 _age) public {
        voterIdAndAge[_id] = _age;
    }

    // we will get the voter age based on id
    function getAge(uint256 _id) public view returns (uint256) {
        return voterIdAndAge[_id];
    }

    // we will get the voteCount info based on name
    function getVott(string memory _name) public view returns (uint256) {
        return voterNameAndMarks[_name];
    }

    function setVotter(uint256 _id, string memory _name) public {
        // in this we can check the person is eligible for vote or not
        if (voterIdAndAge[_id] >= 18) {
            // this will restrict the person if they have already votted
            if (voterNameAndMarks[_name] < 1) {
                voterNameAndMarks[_name] += 1;
                message = "votted done";
            } else {
                // if already votted display this
                message = "you have already votted";
            }
        } else {
            // if age is less than 18 than display this
            message = "you are not not eligible for voting";
        }
    }

    // // it will check that the person is eligible or not
    // function isEligible(uint256 _id) public view returns (bool) {
    //     if (voterIdAndAge[_id] < 18) {
    //         return true;
    //     } else {
    //         return false;
    //     }
    // }
}

contract Election2 {
    // information about the voted person
    string public message;

    // struct datatype is used
    struct voterDetail {
        uint256 Id;
        string Name;
        uint256 age;
        uint256 VoteCount;
    }

    // struct dataType is used in mapping concept
    mapping(string => voterDetail) public VOTER;

    // set the details
    function setDetails(
        string memory _name,
        uint256 _id,
        uint256 _age
    ) public {
        // set the maping and assigning the values
        // string ====> struct
        VOTER[_name] = voterDetail(_id, _name, _age, 0);
    }

    // check if the person is eligible for vote or not based on age
    function isEligible(string memory _name) public {
        // there are two ifElse statement is used
        // 1 ====> for checking the age,if age is greater than 18,then its eligible else not eligible.

        if (VOTER[_name].age > 18) {
            // 2 ===> the second one check that when a person is already voted then
            // it will not applicible for voting again

            if (VOTER[_name].VoteCount < 1) {
                VOTER[_name].VoteCount += 1;
                message = "votted done";
            } else {
                message = "you have already voted(1 time vote is aplicable)";
            }
        } else {
            message = "you are not eligible for vote";
        }
    }
}

contract Election {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
        string details;
    }

    struct Voterss {
        uint256 id;
        string name;
        uint256 age;
        bool voted;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voterss) public voters;

    uint256 public candidatesCount;
    uint256 public votersCount;

    string candidate;

    event votedEvent(uint256 indexed _candidateId);

    function addCandidate(
        uint256 _candidateId,
        string memory _name,
        string memory _details
    ) public {
        candidatesCount++;
        candidates[_candidateId] = Candidate(_candidateId, _name, 0, _details);
    }

    function addVoter(
        uint256 _voterId,
        string memory _name,
        uint256 _age
    ) public {
        votersCount++;
        voters[msg.sender] = Voterss(_voterId, _name, _age, false);
    }

    function vote(uint256 _candidateId) public {
        require(_candidateId == candidates[_candidateId].id, "you");
        require(!voters[msg.sender].voted, "you have already voted");
        require(voters[msg.sender].age >= 18, "you have lowest age");
        candidates[_candidateId].voteCount++;
        voters[msg.sender].voted = true;

        emit votedEvent(_candidateId);
    }
}

contract Mapped {
    // mapping(address => uint256) public Balance;
    // function setBalance(address _address, uint256 _balance) public {
    //     Balance[_address] = _balance;
    // }
    // function getBalance(address _add) public view returns (uint256) {
    //     return Balance[_add];
    // }
    // mapping(address => bool) public owner;
    // function setOwner(address _address, bool _bool) public {
    //     owner[_address] = _bool;
    // }
    // function checkOwner(address _address) public view returns (bool) {
    //     return owner[_address];
    // }
    // function del(address _address) public{
    //     delete owner[_address];
    // }
    // mapping(string => address) public owner;
    // function setOwner(string memory _name, address _address) public {
    //     owner[_name] = _address;
    // }
    // function checkOwner(string memory _name) public view returns (address) {
    //     return owner[_name];
    // }
    // function getAllStruct(uint256 _id) public view returns (College[] memory) {
    //     return record;
    // }
}

contract structContract {
    // struct datatype is used
    struct College {
        string name;
        uint256 age;
    }
    // mapped declared using struct
    mapping(uint256 => College) record;

    function setstruck(
        uint256 _id, //the _id point the key
        string memory _name, //the _name point the struct
        uint256 _age //the _age point the struct
    ) public {
        record[_id] = College(_name, _age);
    }

    function getStruct(uint256 _id) public view returns (College memory) {
        return record[_id];
    }
}

// events contract
contract EventContract {
    string public name;
    uint256 public age;
    event valueChange(string _name, uint256 _age);

    function changeValue(string memory _name, uint256 _age) public {
        name = _name;
        age = _age;
        emit valueChange(_name, _age);
    }
}

contract Election4 {
    string public message;

    //name ===> votts
    mapping(string => uint256) voterNameAndMarks;

    //Id ===> age
    mapping(uint256 => uint256) voterIdAndAge;

    // it will set the voter age based on id
    function setAge(uint256 _id, uint256 _age) public {
        voterIdAndAge[_id] = _age;
    }

    // we will get the voter age based on id
    function getAge(uint256 _id) public view returns (uint256) {
        return voterIdAndAge[_id];
    }

    // we will get the voteCount info based on name
    function getVott(string memory _name) public view returns (uint256) {
        return voterNameAndMarks[_name];
    }

    function setVotter(uint256 _id, string memory _name) public {
        // in this we can check the person is eligible for vote or not
        if (voterIdAndAge[_id] >= 18) {
            // this will restrict the person if they have already votted
            if (voterNameAndMarks[_name] < 1) {
                voterNameAndMarks[_name] += 1;
                message = "votted done";
            } else {
                // if already votted display this
                message = "you have already votted";
            }
        } else {
            // if age is less than 18 than display this
            message = "you are not not eligible for voting";
        }
    }

    // // it will check that the person is eligible or not
    // function isEligible(uint256 _id) public view returns (bool) {
    //     if (voterIdAndAge[_id] < 18) {
    //         return true;
    //     } else {
    //         return false;
    //     }
    // }
}

contract Election3 {
    // information about the voted person
    string public message;

    // struct datatype is used
    struct voterDetail {
        uint256 Id;
        string Name;
        uint256 age;
        uint256 VoteCount;
    }

    // struct dataType is used in mapping concept
    mapping(string => voterDetail) public VOTER;

    // set the details
    function setDetails(
        string memory _name,
        uint256 _id,
        uint256 _age
    ) public {
        // set the maping and assigning the values
        // string ====> struct
        VOTER[_name] = voterDetail(_id, _name, _age, 0);
    }

    // check if the person is eligible for vote or not based on age
    function isEligible(string memory _name) public {
        // there are two ifElse statement is used
        // 1 ====> for checking the age,if age is greater than 18,then its eligible else not eligible.

        if (VOTER[_name].age > 18) {
            // 2 ===> the second one check that when a person is already voted then
            // it will not applicible for voting again

            if (VOTER[_name].VoteCount < 1) {
                VOTER[_name].VoteCount += 1;
                message = "votted done";
            } else {
                message = "you have already voted(1 time vote is aplicable)";
            }
        } else {
            message = "you are not eligible for vote";
        }
    }
}

// contract Election {
//     mapping(uint256 => uint256) private candaite;
//     mapping(string => uint256) public voter;

//     function setvoterdetail(uint256 _ID, uint256 _age) public {
//         candaite[_ID] = _age;
//     }

//     function Eligibilty(uint256 _ID) public view returns (bool) {
//         if (candaite[_ID] >= 18) {
//             return true;
//         } else return false;
//     }

//     function registrationcandidatesvotecount(string memory _name) public {
//         voter[_name] = 0;
//     }

//     function pollvote(uint256 _ID, string memory _name) public {
//         if (Eligibilty(_ID)) {
//             voter[_name] += 1;
//         }
//     }
// }

// contract NewElection{
//     struct Candaite{
//         uint Id;
//         string Name;
//         uint VoteCount;
//         string Details;
//     }
//     struct Voter{
//         uint Id;
//         string Name;
//         uint VoteCount;
//         string Details;
//     }

//     mapping (uint => Candaite) candaiteMapp;
//     mapping (address => Voter) voterMapp;

//     uint public candaiteCount;
//     uint public voterCount;

//     event VoterEvent(uint indexed _candaiteId);

//     function AddCandaite(uint _id,string memory _name,uint _voterCount,string memory _details) public {
//         candaiteMapp[_id].Name = _name;
//         candaiteMapp[_id].Id = _id;
//         candaiteMapp[_id].Details = _details;
//         candaiteMapp[_id].Name = _name;
//         candaiteMapp[_id].Name = _name;
//     }
// }

contract Election10 {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
        string details;
    }

    Candidate can1 = Candidate(1, "ahmad", 0, "pti");

    struct Voterss {
        uint256 id;
        string name;
        uint256 age;
        bool voted;
    }

    mapping(uint256 => Candidate) public candidates;
    mapping(address => Voterss) public voters;

    uint256 public candidatesCount;
    uint256 public votersCount;

    event votedEvent(uint256 indexed _candidateId);

    function addCandidate(
        uint256 _candidateId,
        string memory _name,
        string memory _details
    ) public {
        candidatesCount++;
        candidates[_candidateId] = Candidate(_candidateId, _name, 0, _details);
    }

    function addVoter(
        uint256 _voterId,
        string memory _name,
        uint256 _age
    ) public {
        votersCount++;
        voters[msg.sender] = Voterss(_voterId, _name, _age, false);
    }

    function vote(uint256 _candidateId) public {
        require(
            _candidateId == candidates[_candidateId].id,
            "the candaite Id does not exist"
        );
        require(!voters[msg.sender].voted, "you have already voted");
        require(voters[msg.sender].age >= 18, "you have lowest age");
        candidates[_candidateId].voteCount++;
        voters[msg.sender].voted = true;

        emit votedEvent(_candidateId);
    }
}

contract Election11 {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
        string details;
    }
    Candidate public can1;
    Candidate public can2;
    Candidate public can3;
    Candidate public can4;
    Candidate public can5;

    function setInstance1() public {
        can1 = Candidate(1, "imran", 3, "pti");
        can2 = Candidate(2, "nawaz", 1, "pmln");
        can3 = Candidate(3, "mulana", 2, "jui");
    }

    function setInstance2() public {
        can4 = Candidate({id: 4, name: "imran", voteCount: 10, details: "pti"});
        can5 = Candidate({id: 5, name: "nazir", voteCount: 3, details: "pmln"});
    }
}

contract EmpDetails {
    function Emp(
        uint256 _rollNo,
        string memory _name,
        uint256 _age
    )
        public
        pure
        returns (
            uint256,
            string memory,
            uint256
        )
    {
        return (_rollNo, _name, _age);
    }
}
