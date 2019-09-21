pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;
import "./Info.sol";

contract PatientInfo {
    address public owner;

    Info.patient_info public patient_info;
    event _PatientInfoCreated(address owner);

    constructor(bytes32 _date_of_visit, 
		bytes32 _doctor_name, 
		bytes32 _organization,
	        bytes32 _reason_of_visit,
	        bytes32 _diagnosis,
	        bytes32 _additional_info) public {

	owner = msg.sender;

	Info.patient_info memory info;
	info.date_of_visit = _date_of_visit;
	info.doctor_name = _doctor_name;
	info.organization = _organization;
	info.reason_of_visit = _reason_of_visit;
	info.diagnosis = _diagnosis;
	info.additional_info = _additional_info;

	patient_info = info;

	emit _PatientInfoCreated(owner);
    }

    function getInfo() public returns(Info.patient_info memory info) {
	require(msg.sender == owner);

	return patient_info;
    }
}
