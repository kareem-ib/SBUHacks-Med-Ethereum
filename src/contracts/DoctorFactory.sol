pragma solidity ^0.5.8;
import "./Doctor.sol";

contract DoctorFactory{

    event _ContractCreation(address x);
    constructor() public{
        emit _ContractCreation(address(this));
    }

    event _DocCreated(address Doctor);
    function newDoctor( string memory _mnemonic,
                        bytes32 _fname,
                        bytes32 _lname,
	                    bytes32 _full_name,
                        bytes32 _organization,
                        bytes32 _medical_license,
                        bytes32 _specialization) public{
        Doctor doc = new Doctor( _mnemonic,
                                         _fname,
                                         _lname,
                                         _full_name,
                                         _organization,
                                         _medical_license,
                                         _specialization);
    emit _DocCreated(address(doc));

    }




}