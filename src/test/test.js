const Patient = artifacts.require('Patient');
const Doctor = artifacts.require('Doctor');
const config = require('../config.js');

const patientConfig = config.patient;
const doctorConfig = config.doctor;
const info = config.info;

function p(t) {
    let len = t.length;
    if (t.length < 66)
	for (let i = len; i < 66; i++)
	    t += '0';
}

contract('Patient', accounts => {
    const nonActor = accounts[2];

    it('should add account[1] as doctor', async () => {
	const patient = await Patient.deployed();
	const doctor = await Doctor.deployed();
	const docAddress = doctor.address;
	const patientAddress = patient.address;

	await doctor.approvePatient(doctorConfig.mnemonic, patientConfig.mnemonic, patientAddress);
	const approved = patient.docIsApproved({from: docAddress});
	assert(approved);
    });

    it('should fail account[2] as approved doctor', async () => {
	const patient = await Patient.deployed();

	let approved = await patient.docIsApproved({from: nonActor})
	assert(!approved);
    });

    // it('should add patient info and retrieve last info', async () => {
	// const patient = await Patient.deployed();
	// const doctor = await Doctor.deployed();
	// const docAddress = doctor.address;
	// const patientAddress = patient.address;
    //
	// await doctor.approvePatient(doctorConfig.mnemonic, patientConfig.mnemonic, patientAddress);
	// const approved = patient.docIsApproved({from: docAddress});
	// assert(approved);
    //
	// await doctor.addPatientInfo(doctorConfig.mnemonic,
	//     patientAddress,
	//     info.dateOfVisit,
	//     doctorConfig.fullName,
	//     doctorConfig.organization,
	//     info.reasonForVisit,
	//     info.diagnosis,
	//     info.additionalInfo
	// );
	//
	//
	// const lastDataPoint = await doctor.getLastPatientInfo.call(doctorConfig.mnemonic, patientAddress);
	// assert(
	//     lastDataPoint['0'] == pad(info.dateOfVisit) &&
	//     lastDataPoint['1'] == pad(doctorConfig.fullName) &&
	//     lastDataPoint['2'] == pad(doctorConfig.organization) &&
	//     lastDataPoint['3'] == pad(info.reasonForVisit) &&
	//     lastDataPoint['4'] == pad(info.diagnosis) &&
	//     lastDataPoint['5'] == pad(info.additionalInfo)
	// );
    // });
});
