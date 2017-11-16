pragma solidity ^0.4.11;

contract DataPolicy {

    //States: Init, Accepted, Void, Dissolved

    bytes32 identifier;
    bytes32 hash;
    bytes32 location;

    address controller;
    address processor;

    struct Agreement {
        address identity;
        bytes32 name;
    }

    Agreement[] public agreements;

}

contract Agreement {

    //States: Offered, Binding, Void, Dissolved

    address policy;

    address signatory;
 
    
}

contract Obligation {
    
    address policy;

    bytes32 identifier;
    bytes32 hash;
    bytes32 location;

    struct ObligationEnforcement {
        address agreement;
        address enforcement;
    }

}

contract ObligationEnforcement {

    //State: Dispute, Dissolved, Enforced

    address obligation;

    uint damages;

    //Include parties and payments made? Controller, Processer, Agreement
    //3rd parties have to put forward payments to create enforcement
    //Include link to contract including details of the enforcement?? Document??
    
}