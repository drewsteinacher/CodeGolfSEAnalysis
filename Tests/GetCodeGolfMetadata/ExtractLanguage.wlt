Needs["CodeGolfSEAnalysis`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractLanguage`"];

VerificationTest[
	ExtractLanguage @ SimplifyTitleString["C++, 30 bytes"]
	,
	Entity["CodeGolfProgrammingLanguage", "C::y7pg6"]
	,
	TestID -> "ExtractLanguage-simple-1"
];

VerificationTest[
	ExtractLanguage @ SimplifyTitleString["Python 3.x, 12 bytes"]
	,
	Entity["CodeGolfProgrammingLanguage", "Python::4g426"]
	,
	TestID -> "ExtractLanguage-simple-2"
];


VerificationTest[
	ExtractLanguage @ SimplifyTitleString["Perl 1.2.3 - 12 bytes"]
	,
	Entity["CodeGolfProgrammingLanguage", "Perl::2vj49"]
	,
	TestID -> "ExtractLanguage-simple-3"
];

VerificationTest[
	ExtractLanguage @ SimplifyTitleString["Brain-flak"]
	,
	Entity["CodeGolfProgrammingLanguage", "brain-flak"]
	,
	TestID -> "ExtractLanguage-simplification-override-1"
];

VerificationTest[
	ExtractLanguage @ SimplifyTitleString["Brain-flak, 30 characters"]
	,
	Entity["CodeGolfProgrammingLanguage", "brain-flak"]
	,
	TestID -> "ExtractLanguage-simplification-override-2"
];