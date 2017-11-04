pragma solidity ^0.4.11;

contract TransactionController {
    
    struct Policy {
        address identity;
        bytes32 name;
    }

    Policy[] public policies;

    struct PolicyOwner {
        address identity;
        bytes32 name;
        Policy[] policies;
    }

    mapping (address=>PolicyOwner) owners;
}

contract DataPolicy {

    bytes32 identifier;
    bytes32 hash;
    bytes32 location;

    struct Agreement {
        address identity;
        bytes32 name;
    }

    Agreement[] public agreements;

}

contract DataPolicyAgreement {

    struct Signatory {
        address key;
        bytes32 identfier;
        bool signed;
    }

     Signatory[] private Signatories;

    address Policy;


}


contract DataObligation {
    
}