pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;
import "./Info.sol";
import "./PatientInfo.sol";
import "./Patient.sol";

contract Doctor {

    struct DoctorConstantData {
        bytes32 fname;
        bytes32 lname;
	bytes32 full_name;
        bytes32 organization;
        bytes32 medical_license;
        bytes32 specialization;
	bool exists;
    }

    mapping (bytes32 => DoctorConstantData) public doctor;
    mapping (bytes32 => mapping (address => Patient)) public patients; // all the patients this doctor oversees

    modifier correct_key(string memory _doctor_mnemonic) {
	if (doctor[keccak256(abi.encodePacked(_doctor_mnemonic))].exists) _;
    }

    event _AddNewPatientInfo(address patient);

    constructor(string memory _doctor_mnemonic,
                bytes32 _fname,
                bytes32 _lname,
		bytes32 _full_name,
                bytes32 _organization,
                bytes32 _medical_license,
                bytes32 _specialization) public {

        DoctorConstantData memory doctor_info;
        doctor_info.fname = _fname;
        doctor_info.lname = _lname;
	doctor_info.full_name = _full_name;
        doctor_info.organization = _organization;
        doctor_info.medical_license = _medical_license;
        doctor_info.specialization = _specialization;
	doctor_info.exists = true;

        bytes32 doctor_key = keccak256(abi.encodePacked(_doctor_mnemonic));
        doctor[doctor_key] = doctor_info;
    }
    
    function approvePatient(string memory _doctor_mnemonic, string memory _patient_mnemonic, Patient _patient) correct_key(_doctor_mnemonic) public {
	_patient.addApprovedDoctor(_patient_mnemonic);
	patients[keccak256(abi.encodePacked(_doctor_mnemonic))][address(_patient)] = _patient;	
    }

    function addPatientInfo(string memory _doctor_mnemonic, 
			    address _patient_address,
			    bytes32 _date_of_visit,
			    bytes32 _doctor_name,
			    bytes32 _organization,
			    bytes32 _reason_of_visit,
			    bytes32 _diagnosis,
			    bytes32 _additional_info) public correct_key(_doctor_mnemonic) {
	Patient patient = getPatient(_doctor_mnemonic, _patient_address);
	
	patient.addPatientInfo(_date_of_visit,
			       _doctor_name,
			       _organization,
			       _reason_of_visit,
			       _diagnosis,
			       _additional_info);

	emit _AddNewPatientInfo(_patient_address);
    }

    function getLastPatientInfo(string memory _doctor_mnemonic, address _patient_address) public
    correct_key(_doctor_mnemonic) returns(bytes32, bytes32, bytes32, bytes32, bytes32, bytes32) {
	Patient patient = getPatient(_doctor_mnemonic, _patient_address);
	
	Info.patient_info memory info = patient.getLastPatientInfo();
	return (info.date_of_visit,
		info.doctor_name,
		info.organization,
		info.reason_of_visit,
		info.diagnosis,
		info.additional_info);
    }

    function getNLastPatientInfo(string memory _doctor_mnemonic, address _patient_address, uint N) public correct_key(_doctor_mnemonic) returns(bytes32, bytes32, bytes32, bytes32, bytes32, bytes32) {
	Patient patient = getPatient(_doctor_mnemonic, _patient_address);

	Info.patient_info memory info = patient.getNLastPatientInfo(N);
	return (info.date_of_visit,
		info.doctor_name,
		info.organization,
		info.reason_of_visit,
		info.diagnosis,
		info.additional_info);
    }

    function getPatient(string memory _doctor_mnemonic, address _patient_address) internal view returns (Patient patient) {
	return patients[keccak256(abi.encodePacked(_doctor_mnemonic))][_patient_address];
    }

}








