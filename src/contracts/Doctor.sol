pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;
import "./Info.sol";
import "./PatientInfo.sol";

contract Doctor{

    struct DoctorConstantData{
        bytes32 fname;
        bytes32 lname;
        bytes32 organization;
        bytes32 medical_license;
        bytes32 specialization;

    }

    mapping (bytes32 => DoctorConstantData) public doctor;

    constructor(string memory _mnemonic,
                bytes32 _fname,
                bytes32 _lname,
                bytes32 _organization,
                bytes32 _medical_license,
                bytes32 _specialization) public {

        DoctorConstantData memory doctor_info;
        doctor_info.fname = _fname;
        doctor_info.lname = _lname;
        doctor_info.organization = _organization;
        doctor_info.medical_license = _medical_license;
        doctor_info.specialization = _specialization;

        bytes32 key = keccak256(abi.encodePacked(_mnemonic));
        doctor[key] = doctor_info;
        
    }



}

