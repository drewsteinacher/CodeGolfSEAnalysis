Needs["CodeGolfSEAnalysis`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`ProcessTitle`"];

VerificationTest[
	ProcessTitle[{"Java (163)"}]
	,
	<|
		"TitleString" -> "Java (163)",
		"SimplifiedTitleString" -> "Java (\[ScriptCapitalD]\[ScriptCapitalD]\[ScriptCapitalD])",
		"TitleURLs" -> Missing["NotAvailable"],
		"SizeHistory" -> Missing["NotAvailable"],
		"TitleCodeSnippets" -> Missing["NotAvailable"],
		"Images" -> Missing["NotAvailable"],
		"ReportedSize" -> Quantity[163, "Bytes"],
		"Language" -> Entity["CodeGolfProgrammingLanguage", "Java::6847c"]
	|>
	,
	TestID -> "ProcessTitle-simple-1"
];