const web3 = require('web3');

const f = web3.utils.asciiToHex;
module.exports = {
    doctor: {
	mnemonic: 'some random ass mnemonic please work sir word style class section important',
	fname: f('bob'),
	lname: f('steel'),
	fullName: f('bob steel'),
	organization: f('lutheran'),
	medical_license: f('123456'),
	specialization: f('eye')
    },
    patient: {
	mnemonic: 'index file background services form main lend if you need and any',
	fname: f('jenna'),
	lname: f('cheetos'),
	dob: f('March 30th 1972'),
	ethnicity: f('white'),
	patientAddress: f('4235 42 st, 42188 Dallas, Texas')
    },
    info: {
	dateOfVisit: f('March 30th 2013'),
	reasonForVisit: f('body hurts'),
	diagnosis: f('obseity'),
	additionalInfo: f('how is this person even alive')
    }
}
