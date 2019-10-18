Needs["CodeGolfSEAnalysis`"];
Needs["CodeGolfSEAnalysis`SanitizeBadWords`"];

VerificationTest[
	SanitizeBadWords[Uncompress @ "1:eJxTTMoPCuZkYGBwKkrMzHMrTc4GACpwBRY="]
	,
	"BrainFu\[FreakedSmiley]\[FreakedSmiley]"
	,
	TestID -> "SanitizeBadWords-single-string"
];

VerificationTest[
	SanitizeBadWords[Uncompress @ "1:eJxTTMoPSmNhYGAoBhE+mcUlwZxAhlNRYmaeW2lydjAXiJdZ4pyRmJeeWhTMDuI6Boc4BrkEswLZSZklyRkAKGoQhA=="]
	,
	{"BrainFu\[FreakedSmiley]\[FreakedSmiley]", "BitChanger", "BA\[FreakedSmiley]\[FreakedSmiley]\[FreakedSmiley]\[FreakedSmiley]\[FreakedSmiley]", "bi\[FreakedSmiley]\[FreakedSmiley]\[FreakedSmiley]"}
	,
	TestID -> "SanitizeBadWords-string-list"
];