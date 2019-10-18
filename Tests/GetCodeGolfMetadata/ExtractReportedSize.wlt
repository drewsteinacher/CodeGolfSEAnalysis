Needs["CodeGolfSEAnalysis`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractReportedSize`"];

VerificationTest[
	ExtractReportedSize["C++, 30 bytes"]
	,
	Quantity[30, "Bytes"]
	,
	TestID -> "ExtractReportedSize-simple-1"
];

VerificationTest[
	ExtractReportedSize["Piet, 120 codels (3 bytes)"]
	,
	Quantity[120, IndependentUnit["codels"]]
	,
	TestID -> "ExtractReportedSize-simple-2"
];



VerificationTest[
	ParseReportedSize["120 bytes"]
	,
	Quantity[120, "Bytes"]
	,
	TestID -> "ParseReportedSize-simple-1"
];

VerificationTest[
	ParseReportedSize["120 codels"]
	,
	Quantity[120, IndependentUnit["codels"]]
	,
	TestID -> "ParseReportedSize-simple-2"
];

VerificationTest[
	ParseReportedSize["120"]
	,
	Quantity[120, "Bytes"]
	,
	TestID -> "ParseReportedSize-bare-numbers-assume-bytes"
];

VerificationTest[
	ParseReportedSize["1203 characters"]
	,
	Quantity[1203, IndependentUnit["characters"]]
	,
	TestID -> "ParseReportedSize-characters"
];

VerificationTest[
	ParseReportedSize["1,203 bits"]
	,
	Quantity[1203, "Bits"]
	,
	TestID -> "ParseReportedSize-handle-commas"
];