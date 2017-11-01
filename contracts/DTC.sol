pragma solidity ^0.4.11;

contract DataTransaction {
    
    enum States {
        Init,
        Sign,
        Verified
    }

    struct Signatory {
        address key;
        bytes32 identfier;
        bool signed;
    }

    struct Policy {
        bytes32 identifier;
        bytes32 hash;
        bytes32 location;
    }

    struct Obligation {
        bytes32 identifier;
        address rule;
    }

    address owner;

    States State = States.Init;

    Signatory[] private Signatories; 

    Policy[] private Policies;

    Obligation[] private Obligations;

    uint signatures = 0;

    mapping (address=>uint) signatoryIndex;

    //Init State

    function DataTransaction() public {
        owner = msg.sender;
        Signatories.push(Signatory(msg.sender, "Owner", false)); //Needs work, how can we get the owners name from the repuation contract?
    }

    function initatePolicy(bytes32 identifier,bytes32 document,bytes32 location) public {
        Policies.push(Policy(identifier, document, location));
    }

    function initateObligation(bytes32 identifier,address rule) public {
        Obligations.push(Obligation(identifier, rule));
    }

    function initateSignature() public {
        Signatories[signatoryIndex[owner]].signed = true;
        State = States.Sign;
        signatures++;
    }

    //Sign State

    function sign() public {
        Signatories[signatoryIndex[msg.sender]].signed = true;
        signatures++;
    }

    function verify() public {
        require(signatures == Signatories.length);
         State = States.Verified;
    }

    

}