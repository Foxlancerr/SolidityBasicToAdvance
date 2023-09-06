// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/*
 **************************************************************************************
 **************************************************************************************
 */

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
        require(
            _candidateId == candidates[_candidateId].id,
            "you"
        );
        require(
            !voters[msg.sender].voted,
            "you have already voted"
        );
        require(voters[msg.sender].age >= 18, "you have lowest age");
        candidates[_candidateId].voteCount++;
        voters[msg.sender].voted = true;

        emit votedEvent(_candidateId);
    }
}

/*
   imuttable in solidity

   immutabity is used in that time when we want that the value is assign 1 time and it can not be changer
   ==> it have less cost than constant
   ==> the values must be assign,either in constructer level or either inline level
   ==> the immutable keyword is used
*/

contract immutableContract {
    address public constant add2 = address(1);
    address public immutable add3;

    constructor(address _address) {
        add3 = _address;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

/*
            how to send ether from one contract to another 
                                    OR
            how to send ether from contract to other etherium address

    3 ways to do this ==> send() call() transfer()
    1)send
        used for sended ether
        ==> send function will return bool value (true/false)
        ==> its is used in rare case
        ==> if we used it,so we can apply the reqiure function to revert the gas fees and also revert the changes which is
            done in state varibles if it fail.
        Limitation:
            ==> it have limit 2300 gas fees to perform operation if gas fees is greater than 2300 then it will return false
            and show this kind of error : out of gas.
            ==> if the transiction is failed, then it will not revert the gas fees
        syntex:
                    address ==>this will be payable receiver address
                    address.send(value);
        example:
                    bool returnBool = recieveAddress.send(1 ether);
                    require(returnBool, "not sended");
                            
*/
contract sendEitherContract {
    address payable public recieveAddress =
        payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);

    // in this we can sended ether
    function SendEither() public payable{
        bool returnBool = recieveAddress.send(1 ether);
        require(returnBool, "not sended");
    }

    // in this we can see the ether
    function veiwEther() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}

/*
   1)transfer
        used for sended ether
        ==> transfer function will not return values
        ==> we cannot used the require function because it revert all the changes and gas fees if it fail automitically.
        ==> it have limit 2300 gas fees to perform operation if gas fees is greater than 2300,it will revert it. 
            syntex:
                      recieveAddress.send(1 ether);
*/

contract transferEitherContract {
    address payable public recieveAddress =
        payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);

    // in this we can sended ether
    function TransferEither() public payable {
        recieveAddress.transfer(1 ether);
    }

    // in this we can see the ether
    function veiwEther() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}

/*
    1)call
        used for sended either
        ==> call function will return 2 values 
                bool and data(hexadecimal format)
        ==> we can decide the gas limits by perform operation.
        limitation:
            ==> we can used the require function to revert the transiction and gas fees 
        syntex:
                (bool sent,) = recieverAddress.call{
                                      val:________,
                                      gas:________,
                                    }(" ");
                require(sent, "not sended");

        if we can not declare the gas limit,then by default remixId gas limit is applaid which are 3000000               
*/

contract transferEitherContract {
    address payable public recieveAddress =
        payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);

    // in this we can sended ether
    function callEither() public payable {
        // return 2 values but in here we can catch one value
        (bool sent, ) = recieveAddress.call{value: 1 ether}("");
        require(sent, "not sended");
    }

    // in this we can see the ether
    function veiwEther() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}

// how we send either by providing dynamically address as input
contract AllMethodContract {
    // payable ==> the function will able to send and recieve ether
    //address payable _address ==> convert the address type into payable
    // msg.value ==> store the value which is located in remix id(deploy and run transiction level)

    event log(uint256 value);

    function sendEither(address payable _address) public payable {
        // it will check that the ether is giong in this way or not
        emit log(msg.value);

        // msg.value will recieve dynamically either value and we convert it into payable
        bool sent = _address.send(msg.value);
        require(sent, "not sended");
    }

    // call function
    function callEither(address payable _address) public payable {
        // it will check that the ether is giong in this way or not
        emit log(msg.value);

        // msg.value will recieve dynamically either value and we convert it into payable
        (bool sent, ) = _address.call{value: msg.value}("");
        require(sent, "not sended");
    }

    // transsfer function
    function TransferEither(address payable _address) public payable {
        // it will check that the ether is giong in this way or not
        emit log(msg.value);

        _address.transfer(msg.value);
    }

    // in this we can see the ether
    function veiwEther() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}

// how to recieve contract eth which is sended by other contract
// copy the contract address and paste in that contratc who send eth
contract SendEthContractToContract {
    // in this we can see the ether
    function veiwEther() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
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

/*
 **************************************************************************************
 **************************************************************************************
 */

/*
   Payable keyword
   used:
        to make the function and address payable.
        we also make contructer payable
    1)Address
        if we make the address payable we send either to that address from the contract
        note:
            if we make the address payable we should used payable keyword before the visibility (public,private etc).
            and also typeCast that address into payable,else it will throw error

            syntex:
                  address payable public owner = payable(msg.sender);

    3)constructer
         if we send eth it one time during deploy we make construct payable
         syntex:
               constructor() payable {}
    
    2)Function
        if we make the function payable then we send either to that contract which the payable function present.
        and we store the either in the contract
        note:
            1) the function should not used the view or pure keyword.
            2) the color are red like when the function is payable.
        
        the payable keyword is used when we make our function is payable
        syntex:
                function getEth() payable public{
                        code......
                        ..........
                }
*/

contract PayableContract {
    // make the address payable
    address payable public owner = payable(msg.sender);

    constructor() payable {}

    // declare the fuction payable
    function getEth() public payable {}

    // view the function that it recieve eth or not
    function viewEth() public view returns (uint256) {
        // in here this point to its parent where the fuction is present ===> PayableContract.
        return address(this).balance;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// modifier
/*
    special type of fuction like a constructer.
    what a problem occurs:
        ==> when we need the same code in 20 function,then we write it,
            and this will we create a lot of dublicacy.
            by solving this probrem we can used ==> modifeir

    ==> constructer is also specail type of function,but in a contract there
    one constructer
    ==> but in case of modifiar there are more than 1 modifier in a contract
    note: when we apply modifier to a function so we write before the returns keyword.
    
          i.e function fun1() public pure Modifier returns (string memory) { }

    used: 
         used it that time when you know that the same code will be used again and again
    syntex:
            modifier modifierName {
                starting code.......
                ...........

              _;

                ending code.......
                ...........

              _;
            }

            used:
            function fun1() public pure modifierName returns (string memory) {
                code.......
            }

    working:
            worked with 3 stages
            1) ==> when function is calling so it will excute the modifier code first.
            2) ==> when they reached to this symbol   _;  it will move to the function again and excute the function containing code
            3) ==> after finish the function code, then it will move again to modifier and check if there have any code remaining it,if remaining excuted.

*/
contract ModifierContract {
    // modifier is declared
    modifier sameCode() {
        for (uint256 i = 0; i < 10; i++) {
            // code
        }
        _;
    }

    // used
    function fun1() public pure sameCode returns (string memory) {
        return "hello";
    }

    function fun2() public pure sameCode returns (uint256) {
        return 20;
    }

    function fun3() public pure sameCode returns (bool) {
        return true;
    }
}

contract checkOwnerModifier {
    address public owner = msg.sender;
    // check the owner by using modifier
    modifier checkOwner() {
        require(owner == msg.sender, "not a vilid owner");
        _;
    }

    function fun3() public view checkOwner returns (bool) {
        return true;
    }

    // how to pass input in a modifier

    uint256 public age = 0;
    modifier AgeModifier(uint256 _x) {
        age += _x;
        _;
    }

    function changeAge(uint256 _y) public AgeModifier(_y) {}
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// assert in solidity:

/*
    assert() function have two purposes
    1) to check bug in a code
    2) to check secuirity
    Note:
            not so important,mainly used in rare case
    

    syntex:
                assert(condition);
                
*/

contract AssertContract {
    address public owner = msg.sender;
    uint256 public age = 20;

    function checkOwner() public {
        assert(msg.sender == owner);
        age += 10;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// revert in solidity:

/*
    revert() is used for error handling
    we can pass revert inside the ifElse statement

    syntex:
            if(condition){
                revert(message);
            }    
    In this we have a condition if the condtion is false it will return the message.

*/

contract RevertContract {
    address public owner = msg.sender;
    uint256 public age = 20;

    function checkInputValidation(uint256 _x) public {
        if (_x < 5) {
            revert("value is less than 5");
        } else {
            age += 5;
        }
    }

    function checkOwner() public {
        if (msg.sender != owner) {
            revert("you are not the owner");
        } else {
            age -= 10;
        }
    }

    /*
        error throwError();  ----> custom build Error
            in this we can can declared a custom build error and also we modify it.
            it advantage is that it will reduce the gas cost
            in this we can also pass arguments it behave like the events.
            note:   Errors can only be used with revert statements: "revert MyError(); 
        syntex:
                        error throwError(); ----->this is declaration
                        function called() public{
                            if (_x < 5) {
                                 revert throwError(); ----> called
                            }
                        }
        Note:
                if there have no arguments passed in the error during declation it give default error of the browser.
                if we pass some arguments it throw that error which we define

        error ----> keyword
        throwError---->varaible name

        declation:
                                        error displayError(string name,string city);  ----> behave like events
        called:
                                        revert displayError("ahmad","peshawar");
    */

    // error throwError();
    error throwError(string, uint256);

    function customBuildError(uint256 _x) public {
        if (_x < 5) {
            // revert throwError();
            revert throwError("ahmad", 56);
        } else {
            age += 5;
        }
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

/*
        How to manage error handling is solidty.
        There are 3 ways to handle error.
        1)----> require();
        1)----> assert();
        1)----> revert();

        each have different uses.
        
*/

/*
    require have used for two purposes
    1)input Validation
    2)access control

    syntex
                require(condtion,message);
    In this we have a condition if the condtion is true then a block of code is excuted and if false it will return the message.

    advantages:
                    1)if condition is false then it will return the remaining gas fees.
                    2)if condition is false all the changes which occurs in the states will revert to its initail state.
*/

contract RequiredContract {
    address public owner = msg.sender;
    uint256 public age = 30;

    function checkInputValidation(uint256 _x) public {
        require(_x > 5, "value of x is less then 5");
        age += 5;
    }

    function checkOwner() public {
        age -= 10;
        require(msg.sender == owner, "not valid owner");
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// calling parent funtion
// there are two ways to calling parent function

/*
    1) --->direct calling
        in direct calling there have perairity check
        syntex
               i.e    A.fun1();   C.fun2()

    2)---->calling parent using super keyword
         in super calling it will work based on first come first out and right to left check.
         it will check all the parent unless the required output is getted. 
         syntex
                i.e   super.fun1()  super.fun2()
*/

contract A {
    event Log(string name, uint256 age);

    function fun1() public virtual {
        emit Log("A.fun1", 34);
    }

    function fun2() public virtual {
        emit Log("A.fun2", 35);
    }
}

contract B is A {
    function fun1() public virtual override {
        emit Log("B.fun1", 44);
        A.fun1(); //direct calling
    }

    function fun2() public virtual override {
        emit Log("B.fun2", 45);
        A.fun2(); //direct calling
    }
}

contract C is A {
    function fun1() public virtual override {
        emit Log("C.fun1", 34);
        super.fun1(); //direct calling using super.
        // when there have single parent it behave like direct calling.
    }

    function fun2() public virtual override {
        emit Log("C.fun2", 35);
        super.fun2(); //direct calling using super.
        // when there have single parent it behave like direct calling.
    }
}

contract D is B, C {
    function fun1() public override(B, C) {
        emit Log("D.fun1", 80);
        super.fun1(); // super calling using super keyword.
    }

    function fun2() public override(B, C) {
        emit Log("D.fun2", 35);
        super.fun2(); // super calling using super keyword.
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

//  how to pass constructer values from child to parent in multiple inheratance
// 3 ways to pass values
//  2 ways are----static
//  1 ways are----dynamics
// where we assign the values without giving any arguments
// note:  but we used it combine or even seperates

contract A {
    string public name;
    uint256 public age;

    constructor(string memory _name, uint256 _age) {
        name = _name;
        age = _age;
    }
}

contract B {
    string public grade;
    uint256 public sallary;

    constructor(string memory _grade, uint256 _sallary) {
        grade = _grade;
        sallary = _sallary;
    }
}

// Ist way to assign values -----------> static
// A()------> this will point the constructer of A
// B()------> this will point the constructer of B
// note:  written near to contract(the contract nieghboor and each parent is separated by commas( , )
contract C is A("kamran", 32), B("B_grade", 40000) {

}

// 2nd way to assign values -----------> static
// A()------> this will point the constructer of A
// B()------> this will point the constructer of B
// written near to the constructer and there have no commas to seperate
contract D is A, B {
    constructor() A("Bilal", 12) B("D_grade", 20000) {}
}

// 3rd way to assign values -----------> Dynamicallay
// A()------> this will point the constructer of A
// B()------> this will point the constructer of B
// written near to the constructer and there have no commas to seperate and the parameter which we recieve can pass to
// as argument to its parent because its parent also wants some arguments

contract E is A, B {
    constructor(
        string memory _name,
        uint256 _age,
        string memory _grade,
        uint256 _sal
    ) A(_name, _age) B(_grade, _sal) {}
}


/*
 **************************************************************************************
 **************************************************************************************
 */

//  multiple inheratance
// sequence its follow
// right to left and first to depth

// in multiple inheratance there have a little difference for declaring and using of
// virtual and override keyword which is mention below

// when overide is used
// if parent fuction have same name and fuctionalty, but when the child used it and make to add some additional logics in the same function
// without creating any new function in that time we used it the overide concept

contract A {
    uint256 x;

    constructor() {
        x = 20;
    }

    function funcA() public pure returns (string memory) {
        return "Hello A";
    }

    function funcOveride() public pure virtual returns (string memory) {
        return "Contract A";
    }
}

contract B is A {
    string name;

    constructor() {
        name = "ahmad";
    }

    function funcB() public pure returns (string memory) {
        return "this is B";
    }

    function funcOveride()
        public
        pure
        virtual
        override
        returns (string memory)
    {
        return "Contract B";
    }
}

// in here we can used the override keyword like this override(A,B) because
// in this C have multiple parents and we clearify that you have Multiple parents
contract C is A, B {
    function funcOveride()
        public
        pure
        virtual
        override(A,B)
        returns (string memory)
    {
        return "Contract C";
    }
}

// functionality is same just declaration have a little differnce
contract D is A, B, C {
    function funcOveride()
        public
        pure
        override(A,B,C)
        returns (string memory)
    {
        return "Contract D";
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// Event in solidity
// when we store data only not accessed or not used just for the sake of information
// these data is not store in the blockchain but store in transiction log
// we can see its output in the transiction logs which is present in solidty terminal
//
contract eventContract {
    // account, message, value is used just for readibilty, its not mandatory to assign such names
    // note we can not call the values by its varaibles name,this is just for understanding

    // declaration of events
    event balance(address account, string message, uint256 value);

    function setData(uint256 _val) public {
        // by calling the events we used the [emit] keyword
        emit balance(msg.sender, "hasValue", _val);
    }
}

contract chatApp {
    // the indexed keyword is used in that time when we apply to filter the record based on
    // the given condition,this is mostly used in DApps
    // note: we can declared the [indexed] keyword 3 times per emmit,else theey throw error
    // only applicable for the emmit
    event chat(
        string indexed sender,
        address indexed senderAddress,
        string indexed reciver,
        address recieverAddress,
        string message,
        uint256 time
    );

    function sendMessage(
        string memory _sender,
        string memory _reciever,
        address _reciverAddress,
        string memory _message
    ) public {
        emit chat(
            _sender,
            msg.sender,
            _reciever,
            _reciverAddress,
            _message,
            block.timestamp
        );
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// inheratance in solidity
// when the child can carry his parent properties
// virtual
// the virtual keyword is used to allow access to its child that you will modify the changes
// this will be used only parent but if the children have sub children then it used
// virtual ----> for parent level we used it
// override
// override keyword is used to change and modify the data
// virtual and override are related and both used at a time
// the children who access the parent function and make to modify the function
// override -----> for children level we used it

contract GrandParent {
    string public name;

    function details(string memory _name) public returns (string memory){
        name = _name;
        return name;
    }

    function greet() public pure virtual returns (string memory) {
        return "GrandParent";
    }
}

contract Parent is GrandParent {
    function greet() public pure virtual override returns (string memory) {
        return "Parent";
    }
}

contract child is Parent {
    function greet() public pure override returns (string memory) {
        return "child";
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// visibility
// public   private   internal   external
// 1)public
// this is accesable every where like within the function, outside the functiom,within inheratance,without inhearatance

// 2)private
// only accesable on that contract where they defined

// 3)external
// not allow with that contract where they define and also its children,but we can access outside from the contract

// internal
// within where they define and its child contract it will allow it

contract A {
    string public stu1 = "ahmad";
    string internal stu2 = "sudais";
    string private stu3 = "imran";

    // we can not used external with a dataTypes,because it can through error
    // string external stu4 = "oziafa";

    function viewPublic() public pure returns (string memory) {
        return "public";
    }

    function viewPrivate() private pure returns (string memory) {
        return "Private";
    }

    function viewInternal() internal pure returns (string memory) {
        return "internal";
    }

    function viewExternal() external pure returns (string memory) {
        return "external";
    }
}

contract B is A {
    function checkVisibility() public pure {
        viewInternal();
        viewPublic();
        // not accessable here because its is children of contract A
        // viewExternal();
        // viewPrivate();
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

//  task 1
// creatting a simple voting system that will allow the user to vote.
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

/*
 **************************************************************************************
 **************************************************************************************
 */

//  mapping
// we can not used mapping outside the contract(file level) and not inside the function
// only we used in contract level(inside the contract)
contract mappContract {
    //  key value pair(key => value)
    // work like a table
    mapping(uint256 => string) public empRecord;

    function setValues() public {
        empRecord[0] = "ahmad";
        empRecord[1] = "sudais";
        empRecord[2] = "muskan";
        empRecord[3] = "ajmal";
    }

    struct donorData {
        uint256 Id;
        string Name;
        string City;
    }

    mapping(address => donorData) public accInfo;

    function set(uint _id,string memory _name,string memory _city) public {
        accInfo[msg.sender] = donorData(_id,_name,_city); 
    }
}

// used strut in mapping
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

/*
 **************************************************************************************
 **************************************************************************************
 */

// struct datatype(user defined)
contract structContract {
    // such datatype which have grouped more inbuild datatypes
    // store in the storage
    // look like javascript object
    // let emp{
    // name,
    // age,
    // city
    // }
    // this will be used everywhere[within contract, outside of contract,within the function]
    struct Emp {
        string name;
        uint256 age;
    }

    Emp public emp;
    Emp[] empArr;

    function setStructValues() public {
        // there are three ways to initailize the values
        // Emp memory emp1 = Emp("ahmad", 45);
        // Emp memory emp2 = Emp({name: "kamran", age: 56});
        // Emp memory emp3;
        // emp3.name = "imran";
        // emp3.age = 55;

        // 1)
        Emp memory emp1 = Emp("ahmad", 45);
        emp = emp1;

        // 2)
        Emp memory emp2 = Emp({name: "kamran", age: 56});

        // 3)
        Emp memory emp3;
        emp3.name = "imran";
        emp3.age = 55;
        // we push the data into the arrays
        empArr.push(emp1);
        empArr.push(emp2);
        empArr.push(emp3);
        empArr.push(Emp("sudais", 65));

        // the (memory keyword is used here because it store data in memory)
    }

    // update the struct values
    function updateStruct(
        uint256 _index,
        string memory _name,
        uint256 _age
    ) public {
        if (empArr.length > 0) {
            empArr[_index].name = _name;
            empArr[_index].age = _age;
        } else {
            empArr.push(Emp("test", 100));
        }
    }

    // delete values from the struct
    function delStructValue(uint256 _index) public {
        delete empArr[_index].name;
        delete empArr[_index].age;
    }

    // in this we can view all the data present in the arrays
    function ViewData() public view returns (Emp[] memory) {
        return empArr;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// working with enum datatypes
contract enumContract {
    // enum is user-defined datatype
    // used the concept of boolean but boolean have a 1 chiose
    // i.e IsEligible = false/true 0/1;
    // but in enum we have more than 1 chioce and its value depends on user
    // i.e product shipping is perfect example
    // pending,order,shipped,cancel,complete etc
    // this will be used everywhere[within contract, outside of contract,within the function]

    // we create enum
    enum Status {
        // this is accessable like array [0,1,2,3,4]
        // 0------pending
        // 1------shipped
        // 2------reject
        // 3------accept
        // 4------cancel
        Pending,
        Shipped,
        Reject,
        Accept,
        Cancel
    }

    Status statusContainer;

    function get() public view returns (Status) {
        return statusContainer;
    }

    function getAndDisplayMessage(Status _i)
        public
        pure
        returns (string memory message)
    {
        if (Status.Accept == _i) {
            message = "accepted";
        } else if (Status.Reject == _i) {
            message = "rejected";
        } else if (Status.Cancel == _i) {
            message = "Cancel";
        } else if (Status.Shipped == _i) {
            message = "Shipped";
        } else {
            message = "still pending";
        }

        return message;
    }

    function setStatus(Status _int) public {
        statusContainer = _int;
    }

    function reject() public {
        statusContainer = Status.Reject;
    }

    function accept() public {
        statusContainer = Status.Accept;
    }

    function resetStatus() public {
        delete statusContainer;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// working with arrays
contract arrayContract {
    // dynamics arrays
    uint256[] ageArray;
    uint256[] ageArrayWithValues = [90, 34, 23, 45, 23, 45, 67, 23, 98];
    // fixed sized array
    // if the values is not assign by default values will be store
    uint256[4] fixedSiedArray;

    function shiftArray(uint256 _i) public {
        // in this the shifing will ocurrs
        // [3,6,7,4] =>remove(2) => [3,7,4]
        require(_i < ageArrayWithValues.length, "array have no el");

        for (uint256 i = _i; i < ageArrayWithValues.length - 1; i++) {
            ageArrayWithValues[i] = ageArrayWithValues[i + 1];
        }
        ageArrayWithValues.pop();
    }

    function getArray() public view returns (uint256[] memory) {
        // view all the values in the array
        return ageArrayWithValues;
    }

    function getSingle(uint256 _i) public view returns (uint256) {
        // only specific index value will be viewed
        return ageArray[_i];
    }

    function puchOperation(uint256 _i) public {
        // this will incease the array lenght by 1
        // and add this value at last index
        ageArray.push(_i);
    }

    function popOperation() public {
        // this will remove the last element
        ageArray.pop();
    }

    function getLenght() public view returns (uint256) {
        // give the aray lenght
        return ageArray.length;
    }

    function deleteIndex(uint256 _i) public {
        // its reset the value at index to its default value
        delete ageArray[_i];
    }

    //   function ArrayInMemory() external {
    //     // create array in memory,only fixed size can be created
    //     uint256[] memory arr = new uint256[](3);
    //   }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

//nested Mapping
contract nestedMappingContract {
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _add, uint256 _i) public view returns (bool) {
        return nested[_add][_i];
    }

    function set(
        address _add,
        uint256 _i,
        bool _bool
    ) public {
        // update the values at this address
        nested[_add][_i] = _bool;
    }

    function remove(address _add, uint256 _i) public {
        // reset the value to the default values
        delete nested[_add][_i];
    }
}

//Mapping
// mapping(keytype => valuetype)
// keytype have any datatype value(int,string,bool etc)
// only mapping the arrays
// mapping also return the values if not define it return default values
contract MappingContract {
    mapping(address => uint256) public myMap;

    function get(address _add) public view returns (uint256) {
        return myMap[_add];
    }

    function set(address _add, uint256 _i) public {
        // update the values at this address
        myMap[_add] = _i;
    }

    function remove(address _add) public {
        // reset the value to the default values
        delete myMap[_add];
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// solidity modifier
contract workWithModifier {
    uint256 public age = 20;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // important
    // modifier are code that can br run before and after the function call
    // generally we used modifier for three reasons
    // restrict access, validate data, guard against reentrancy hack

    modifier onlyOwner() {
        require(msg.sender == owner, "not a valid owner");
        _;
    }

    modifier validateData(address _add) {
        require(_add != address(0), "not a valid address");
        _;
    }

    function changeOwner(address _newOwner)
        public
        onlyOwner
        validateData(_newOwner)
    {
        owner = _newOwner;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// assert / check overflow used in solidity
contract AssertUsed {
    function checkInput(uint256 _value1, uint256 _value2)
        public
        pure
        returns (string memory)
    {
        uint256 sum = _value1 + _value2;
        assert(sum >= 10);
        return "value is greater than 10";
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// require used in solidity
contract requireUsed {
    function checkInput(uint256 _value) public pure {
        require(_value >= 10, "the value is less than 10");
        require(_value <= 10, "the value is greater than 10");
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// events ticker system
contract eventTicket {
    uint256 startAt;
    uint256 endIt;
    string ticketMessage = "buy the tickets";
    uint256 ticketPrice;
    uint256 totalAmount;
    uint256 ticketNumber;
    uint256 timeRange;

    constructor(uint256 _ticketPrice) {
        startAt = block.timestamp;
        ticketPrice = _ticketPrice;
        timeRange = (startAt - endIt) / 60 / 60 / 24;
        endIt = block.timestamp - 7 days;
    }

    function buyTicket(uint256 _value) public returns (uint256 _ticketId) {
        ticketNumber++;
        totalAmount = _value;
        ticketNumber = _ticketId;
        return (ticketNumber);
    }

    function getTicketAmount() public view returns (uint256 _total) {
        return totalAmount;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// for loop, while loop and do while loop
// all loop statement are working within the function,it does not work with the contract
// means we can create a function inside the contract and then within function we apply all these loops

contract loapsContract {
    //for loop is used for looping
    //it have take three condition
    // (inailization condition increment/decreament)
    function forLoap() public pure returns (uint256) {
        uint256 num = 0;
        for (uint256 i = 0; i < 2; i++) {
            num += 5;
        }
        return num;
    }

    // while loop is also used for looping
    // it will first check condition and then loop it until the condition is false
    // the increment condition is appliad at last within the curly brakets
    function whileLoop() public pure returns (uint256) {
        uint256 num = 0;
        uint256 age = 10;
        while (num <= 2) {
            age += 1;
            num++;
        }
        return age;
    }

    // Do while loop is also used for looping but in here
    // if the condition is false or true it will be excuted at least one time
    // first it will loop it and then increment it and then check condition
    function doWhileLoop() public pure returns (uint256) {
        uint256 num = 0;
        uint256 age = 10;
        do {
            age += 1;
            num++;
        } while (num > 2);
        return age;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// if else statements
contract ifElseContract {
    // if else statement is working within the function,it does not work with the contract level
    // means if else statement is is locally accessible
    function ifElseFunc(uint256 _num) public pure returns (string memory) {
        string memory valOutput;
        if (_num > 100) {
            valOutput = "the value is greater than 100";
        } else if (_num < 100) {
            valOutput = "the value is less than 100";
        } else {
            valOutput = "the value is equal to 100";
        }

        // ternary operater if else statement if true (1st condition is returned) if false (second condition is returned)
        
        /*
                valOutput = _num>100 ? valOutput = "the value is greater then 100"
                                     : valOutput = "the value is less then 100";
                 
                 valOutput = _num>100 ? valOutput = "the value is greater then 100" 
                                      : valOutput = "the value is less then 100";
                 return valOutput;
        */
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// constructer in solidity
contract constructorContract {
    uint256 public marks = 24;
    string public city;
    string public name;

    // the constructer function is used to inailize the value for the state varaibles.
    // each contract have only one constructer function
    // this is the first which excuted and assign its values if given or mendatory
    constructor(string memory _name, string memory _city) {
        marks = 40;
        name = _name;
        city = _city;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// constant in solidity
contract constantContract {
    // the constant keyword is used when we not change the value of the varaibles
    // constant keyword can utilize less gas than the other datatypes varaibles
    uint256 public constant age = 45;
    address public owner = msg.sender;

    // function tryToChangeConstantValue() public returns (uint){
    //     // cannot assign values because its constant and throw error
    //     return age +=20;
    // }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// string in solidity
contract stringContract {
    string public name = "ahmad";

    // by default string is store in the blockcahin storage
    // and when we used string as local varaibles we used the (memory) keyword, the example are given below
    function stringFunc(string memory _city)
        public
        pure
        returns (string memory, string memory)
    {
        string memory localName = "sohail";
        string memory city = _city;
        return (localName, city);
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

//pure view and simple functions keyword
contract pureVeiw {
    uint256 public age = 20;

    // pure are used when we don't need to modify and read the state varibles values and it is related to the state varibles very low gas fees
    function funcPure(uint256 _x, uint256 _y) public pure returns (uint256) {
        return _x + _y;
    }

    // view are used when we only read the the state varaibles data and not modify it and it take a little gas fees
    function funcView() public view returns (uint256) {
        return age;
    }

    // there have no view and pure keyword in the function and it also modify the state varaibles data and also read it.
    function funcNotViewPure() public {
        age += 10;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// global variables
contract globalVariableScope {
    // global variables are predefined vailable and we cna not use as varaibles names for other variables
    // here are some exapmles
    //msg.sender(address);   msg.value(uint);   block.timestamp(uint);   block.difficulty(uint); block.coinbase(address)

    address public owner = msg.sender;
    uint256 public blockDifficulty = block.timestamp;
    address public blockCionbase = block.coinbase;
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// local varaibles
contract localVaraibleScope {
    uint256 public age;
    bool public boolean;
    uint256 public result;

    // local varaibles are used within the function and its is store in the memory (RAM)
    // when the function get complete its excution so it will leave the the storage ,due to which
    // it not take space in the storage and its gas fees is very low.
    function setLocalVaraibles(uint256 _age, bool _bool)
        public
        returns (
            uint256,
            bool,
            uint256
        )
    {
        // that are local varaibles
        uint256 x = 100;
        uint256 y = 20;
        age = _age;
        result = x + y;
        boolean = _bool;
        return (result, boolean, age);
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// state varaibles
contract stateVaraibleScope {
    // state varaible are present inside the contract and outside from the function.
    // permanatly store and take space in the blockcahin
    // its cost worthy because it can take storage in the blockcahin and we pay gas fees
    // there are three method to initailize the state variables
    // 1) uint public salary = 2000   uint public age;
    // 2) within constructer
    // 3) by using function to assign values

    uint256 public salary = 1000;
    uint256 public age;

    constructor() {
        age = 20;
    }

    function assignValues() public {
        salary = 20000;
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// all about function in solidity
contract FunctionDetails {
    uint256 age = 20;

    // pure function
    // which can not modify the state and not read it
    function mulValues(uint256 _x, uint256 _y) public pure returns (uint256) {
        return _x * _y;
    }

    // without pure and view
    // it can modify the states and also read it
    function incrementAge() public {
        age += 1;
    }

    // view function can read the data and not modify it
    function getAge() public view returns (uint256) {
        return age;
    }

    function internalAge() internal {
        // your code is here
    }
}

/*
 **************************************************************************************
 **************************************************************************************
 */

// simple contract ---My first contract:
contract SimpleContract {
    address public owner;

    // this constructer will do to store the address when we click on the deploy
    constructor() {
        owner = msg.sender;
    }

    // only owner will allow to access the data
    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    // this will set to the new owner
    function setOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "invalid address");
        owner = _newOwner;
    }
}
