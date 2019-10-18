Needs["CodeGolfSEAnalysis`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`SimplifyTitleString`"];

VerificationTest[
	SimplifyTitleString["C++, 30 bytes"]
	,
	"C++\[ScriptCapitalS] \[ScriptCapitalD]\[ScriptCapitalD] \[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]"
	,
	TestID -> "SimplifyTitleString-simple-1"
];

VerificationTest[
	SimplifyTitleString["Python 3.x, 12 bytes"]
	,
	"Python \[ScriptCapitalV]\[ScriptCapitalV]\[ScriptCapitalV]\[ScriptCapitalS] \[ScriptCapitalD]\[ScriptCapitalD] \[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]"
	,
	TestID -> "SimplifyTitleString-simple-2"
];


VerificationTest[
	SimplifyTitleString["Perl 1.2.3 - 12 bytes"]
	,
	"Perl \[ScriptCapitalV]\[ScriptCapitalV]\[ScriptCapitalV]\[ScriptCapitalV]\[ScriptCapitalV] \[ScriptCapitalS] \[ScriptCapitalD]\[ScriptCapitalD] \[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]"
	,
	TestID -> "SimplifyTitleString-simple-3"
];

VerificationTest[
	SimplifyTitleString["Brain-flak"]
	,
	"Brain-flak"
	,
	TestID -> "SimplifyTitleString-simplification-override-1"
];

VerificationTest[
	SimplifyTitleString["Brain-flak, 30 characters"]
	,
	"Brain-flak\[ScriptCapitalS] \[ScriptCapitalD]\[ScriptCapitalD] \[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]\[ScriptCapitalC]"
	,
	TestID -> "SimplifyTitleString-simplification-override-2"
];