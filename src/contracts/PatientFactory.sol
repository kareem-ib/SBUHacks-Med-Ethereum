pragma solidity ^0.5.8;
import "./Patient.sol";

contract PatientFactory{

    event _ContractCreation(address x);
    constructor() public{
        emit _ContractCreation(address(this));
    }

    event _PatientCreated(address Patient);
    function newPatient(string memory _mnemonic,
                        bytes32 _fname,
                        bytes32 _lname,
                        bytes32 _date_of_birth,
                        bytes32 _ethnicity,
                        bytes32 _patient_address) public{
        Patient Patient = new Patient( _mnemonic,
                                         _fname,
                                         _lname,
                                         _date_of_birth,
                                         _ethnicity,
                                         _patient_address);
    emit _PatientCreated(address(Patient));

    }
}