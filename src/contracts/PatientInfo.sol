pragma solidity ^0.5.8;
import "./Info.sol";

contract PatientInfo {
    address public owner;

    mapping (bytes32 => Info.patient_info) private hashed_info;
    event _PatientInfoCreated(address owner);

    constructor(bytes32 _key, 
		bytes32 _date_of_visit, 
		bytes32 _doctor_name, 
		bytes32 _organization,
	        bytes32 _reason_of_visit,
	        bytes32 _diagnosis,
	        bytes32 _additional_info) public {

	bytes32 memory key = keccak256(_key);
	owner = msg.sender;

	Info.patient_info memory info;
	info.date_of_visit = _date_of_visit;
	info.doctor_name = _doctor_name;
	info.organization = _organization;
	info.reason_of_visit = _reason_of_visit;
	info.diagnosis = _diagnosis;
	info.additional_info = _additional_info;

	hashed_info[key] = info;
	emit _PatientInfoCreated(owner);
    }

    function getInfo(bytes32 _key) public returns(Info.patient_info memory info) {
	return hashed_info[keccak256(_key)];
    }
}
