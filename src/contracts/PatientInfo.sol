pragma solidity ^0.5.11;

contract PatientInfo {
    address public owner;

    struct Info {
	bytes32 date_of_visit;
	bytes32 doctor_name;
	bytes32 organization;
	bytes32 reason_of_visit;
	bytes32 diagnosis;
	bytes32 additional_info;
    }

    mapping (bytes32 => Info) private hashed_info;
    event _PatientCreated(address owner);

    constructor(bytes32 _key, 
		bytes32 _date_of_visit, 
		bytes32 _doctor_name, 
		bytes32 _organization,
	        bytes32 _reason_of_visit,
	        bytes32 _diagnosis,
	        bytes32 _additional_info) public {

	bytes32 memory key = keccak256(_key);
	owner = msg.sender;

	Info memory info;
	info.date_of_visit = _date_of_visit;
	info.doctor_name = _doctor_name;
	info.organization = _organization;
	info.reason_of_visit = _reason_of_visit;
	info.diagnosis = _diagnosis;
	info.additional_info = _additional_info;

	hashed_info[key] = info;
	emit _PatientCreated(owner);
    }

    function getInfo(bytes32 _key) public returns(Info) {
	return hashed_info[keccak256(_key)];
    }
}
