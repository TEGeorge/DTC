pragma solidity ^0.4.11;

contract DataTransactionContract {

    enum States {
        Proposal,
        Signiture,
        Verfication,
        Agreement,
        Disputed
    }

    struct Party {
        address identity;
        bytes32 name;
        bool signed;
        bool verfied;
    }

    mapping (address=>uint) partyMembers;

    address owner;

    States state = States.Proposal;

    Party[] public parties;

    bytes32 public dataDef;

    function DataTransactionContract() {
        owner = msg.sender;
        addParty(msg.sender, "Contract Owner");
    }

    function setDataDef(bytes32 def)
        isState(States.Proposal)
        isOwner(msg.sender)
    {
        dataDef = def;
    }

    function addParty (address identity, bytes32 name)
        isState(States.Proposal)
        isOwner(msg.sender)
    {
        parties.push(Party(identity, name, false, false));
    }

    function initSign () 
        isOwner(msg.sender)
    {
        state = States.Signiture;
        parties[partyMembers[owner]].signed = true;
    }

    function sign ()
        isState(States.Signiture)
    {
        uint party = partyMembers[msg.sender];
        parties[party].signed = true;

    }

    function initVerify()
        isOwner(msg.sender)
        isState(States.Signiture)
    {
        for (uint i = 0; i < parties.length; i++) {
            if (!parties[i].signed) 
                revert();
        }
        state = States.Verfication;
    }

    function initAgreement() 
        isOwner(msg.sender)
        isState(States.Verfication)
    {
        state = States.Agreement;
    }

    

    modifier isState(States _state) {
        require(state == _state);
        _;
    }

    modifier isOwner(address _owner) {
        require(owner == _owner);
        _;
    }
}