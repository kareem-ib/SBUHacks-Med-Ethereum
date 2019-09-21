pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;
import "./Info.sol";
import "./PatientInfo.sol";

contract Patient {
    address public owner;

    struct PatientConstantData {
	bytes32 fname;
	bytes32 lname;
	bytes32 date_of_birth;
	bytes32 ethnicity;
	bytes32 patient_address;
	bool exists;
    }

    mapping (bytes32 => PatientConstantData) public patient;
    PatientInfo[] public patient_history;

    event _PatientCreated(address owner);
    event _PatientHistoryUpdated();

    modifier correct_key(string memory _key) {
	if (patient[keccak256(abi.encodePacked(_key))].exists) _;
    }

    constructor(string memory _mnemonic,
		bytes32 _fname,
		bytes32 _lname,
		bytes32 _date_of_birth,
		bytes32 _ethnicity,
		bytes32 _patient_address) public {

	owner = msg.sender;

	PatientConstantData memory _patient;
	_patient.fname = _fname;
	_patient.lname = _lname;
	_patient.date_of_birth = _date_of_birth;
	_patient.ethnicity = _ethnicity;
	_patient.patient_address = _patient_address;

	bytes32 key = keccak256(abi.encodePacked(_mnemonic));
	patient[key] = _patient;
	emit _PatientCreated(owner);
    }

    function addPatientInfo(string memory _mnemonic,
			    bytes32 _date_of_visit,
			    bytes32 _doctor_name,
			    bytes32 _organization,
			    bytes32 _reason_of_visit,
			    bytes32 _diagnosis,
			    bytes32 _additional_info) public correct_key(_mnemonic) {

	PatientInfo patient_info = new PatientInfo(_mnemonic,
						   _date_of_visit,
						   _doctor_name,
						   _organization,
						   _reason_of_visit,
						   _diagnosis,
						   _additional_info);
	patient_history.push(patient_info);	
	emit _PatientHistoryUpdated();
    }

    function getLastPatientInfo(string memory _mnemonic) public view correct_key(_mnemonic) returns(Info.patient_info memory info) {
	return patient_history[patient_history.length - 1].getInfo(_mnemonic);
    }

    function getNLastPatientInfo(string memory _mnemonic, uint N) public view correct_key(_mnemonic) returns(Info.patient_info memory info) {
	require(N <= patient_history.length);
	return patient_history[patient_history.length - N].getInfo(_mnemonic);
    }

    function getFirstName(string memory _mnemonic) public view correct_key(_mnemonic) returns(bytes32) {
	return patient[keccak256(abi.encodePacked(_mnemonic))].fname;
    }

    function getLastName(string memory _mnemonic) public view correct_key(_mnemonic) returns(bytes32) {
	return patient[keccak256(abi.encodePacked(_mnemonic))].lname;
    }

    function getDateOfBirth(string memory _mnemonic) public view correct_key(_mnemonic) returns(bytes32) {
	return patient[keccak256(abi.encodePacked(_mnemonic))].date_of_birth;
    }

    function getEthnicity(string memory _mnemonic) public view correct_key(_mnemonic) returns(bytes32) {
	return patient[keccak256(abi.encodePacked(_mnemonic))].ethnicity;
    }

    function getPatientAddress(string memory _mnemonic) public view correct_key(_mnemonic) returns(bytes32) {
	return patient[keccak256(abi.encodePacked(_mnemonic))].patient_address;
    }
}







