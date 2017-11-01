pragma solidity ^0.4.11;

contract DataTransaction {
    
    enum States {
        Init,
        Sign,
        Verified
    }

    struct Signatory {
        address key;
        byte32 identfier;
        bool signed;
    }

    struct Policy {
        byte32 identifier;
        hash document;
        byte32 location;
    }

    struct Obligation {
        byte32 identifier;
        address rule;
    }

    address Owner;

    States State = States.Init

    Signatory[] private Signatories; 

    Policy[] private Policies;

    Obligation[] private Obligations;

    uint signatures = 0;

    mapping (address=>uint) signatoryIndex;

    //Init State

    function DataTransaction() {
        owner = msg.sender;
        Signatories.push(Signatory(msg.sender, "Owner", false)); //Needs work, how can we get the owners name from the repuation contract?
    }

    function initatePolicy(identifier, document, location) {
        Policies.push(Policy(identifier, document, location));
    }

    function initateObligation(identifier, rule) {
        Obligations.push(Obligation(identifier, rule));
    }

    function initateSignature() {
        State = States.Sign;
        Signatories.signatoryIndex[Owner].signed = true;
        signatures++;
    }

    //Sign State

    function sign() {
        Signatories.signatoryIndex[msg.sender].signed = true;
        signatures++;
    }

    function verify() {
        requre(signatures == Signatories.length)
         State = States.Verfied;
    }

    

}