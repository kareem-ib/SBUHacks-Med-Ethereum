pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;
import "./Info.sol";
import "./PatientInfo.sol";

contract Patient {
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
    mapping (address => bool) public approved_doctors;

    event _PatientCreated();
    event _PatientHistoryUpdated();
    event _AddedNewDoctor(address doctor);

    modifier correct_key(string memory _key) {
	if (patient[keccak256(abi.encodePacked(_key))].exists) _;
    }
    
    modifier approved_doctor(address doctor) {
	if (approved_doctors[doctor]) _; // Check that the person calling this method is the doctor
    }
    
    constructor(string memory _mnemonic,
		bytes32 _fname,
		bytes32 _lname,
		bytes32 _date_of_birth,
		bytes32 _ethnicity,
		bytes32 _patient_address) public {

	PatientConstantData memory _patient;
	_patient.fname = _fname;
	_patient.lname = _lname;
	_patient.date_of_birth = _date_of_birth;
	_patient.ethnicity = _ethnicity;
	_patient.patient_address = _patient_address;
	_patient.exists = true;

	bytes32 key = keccak256(abi.encodePacked(_mnemonic));
	patient[key] = _patient;
	emit _PatientCreated();
    }

    function addApprovedDoctor(string memory _mnemonic) public correct_key(_mnemonic) {
	approved_doctors[msg.sender] = true;
	emit _AddedNewDoctor(msg.sender);
    }
    
    function docIsApproved() public view approved_doctor(msg.sender) returns(bool) {
	return true;
    }

    function addPatientInfo(bytes32 _date_of_visit,
			    bytes32 _doctor_name,
			    bytes32 _organization,
			    bytes32 _reason_of_visit,
			    bytes32 _diagnosis,
			    bytes32 _additional_info) public approved_doctor(msg.sender) {

	patient_history.push(new PatientInfo(_date_of_visit,
		    _doctor_name,
		    _organization,
		    _reason_of_visit,
		    _diagnosis,
		    _additional_info));
    }

    event _Y(PatientInfo a);
    function getLastPatientInfo() public approved_doctor(msg.sender) returns(Info.patient_info memory info) {
	require(patient_history.length > 0);
	emit _Y(patient_history[patient_history.length - 1]);
	return (patient_history[patient_history.length - 1]).getInfo();
    }

    function getNLastPatientInfo(uint N) public approved_doctor(msg.sender) returns(Info.patient_info memory info) {
	require(N <= patient_history.length);
	return patient_history[patient_history.length - N].getInfo();
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







