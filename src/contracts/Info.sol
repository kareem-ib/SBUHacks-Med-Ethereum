pragma solidity ^0.5.8;
library Info{

    struct patient_info {
        bytes32 date_of_visit;
        bytes32 doctor_name;
        bytes32 organization;
        bytes32 reason_of_visit;
        bytes32 diagnosis;
        bytes32 additional_info;
    }

}
