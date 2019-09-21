const Info = artifacts.require("Info");
const PatientInfo = artifacts.require("PatientInfo");
const Patient = artifacts.require("Patient");
const Doctor = artifacts.require("Doctor");
const DoctorFactory = artifcats.require("DoctorFactory");
const PatientFactory = artifcats.require("PatientFactory");


const config = require('../config.js');
const doctor = config.doctor;
const patient = config.patient;

module.exports = function(deployer, network, accounts) {
    deployer.deploy(Info);
	deployer.link(Info, [PatientInfo, Patient, Doctor, DoctorFactory, PatientFactory]);
    // const info = await Info.new()
    // await PatientInfo.link(Info, info.address);
    // const m = await PatientInfo.new(patient.dob, patient.dob, patient.dob, patient.dob, patient.dob, patient.dob);
	//deployer.link(Info, [PatientInfo, Patient, Doctor]);

    // console.log('SSFF', patient.fname);
    // deployer.deploy(Patient, 
	// patient.mnemonic,
	// patient.fname,
	// patient.lname,
	// patient.dob,
	// patient.ethnicity,
	// patient.patientAddress,
	// { from: accounts[0] }
    // );
    // deployer.deploy(Doctor,
	// doctor.mnemonic,
	// doctor.fname,
	// doctor.lname,
	// doctor.fullName,
	// doctor.organization,
	// doctor.medical_license,
	// doctor.specialization,
	// { from: accounts[1] }
	// );
	
	deployer.deploy(DoctorFactory);
	deployer.deploy(PatientFactory);

};
