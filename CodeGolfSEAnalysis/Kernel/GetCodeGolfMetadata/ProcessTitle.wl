BeginPackage["CodeGolfSEAnalysis`GetCodeGolfMetadata`ProcessTitle`",
	{
		"CodeGolfSEAnalysis`",
		"CodeGolfSEAnalysis`GetCodeGolfMetadata`"
	}
];

Begin["`Private`"];

ProcessTitle[___] := <||>;

ProcessTitle[titleContents_List] := Module[
	{titleString, sownData, simplifiedTitleString},
	
	(* Create a string *)
	{titleString, sownData} = iProcessTitle[titleContents];
	sownData = Association[sownData];
	
	titleString = Replace[
		SanitizeBadWords[titleString],
		{
			l : {__String} :> StringReplace[
				StringJoin[l],
				{
					Whitespace -> " ",
					"," ~~ Whitespace ~~ "," -> ", ",
					
					StartOfString ~~ ("use" | "in" | (DigitCharacter .. ~~ ".")) ~~ Whitespace -> "",
					(StartOfString ~~ LetterCharacter?UpperCaseQ ~~ " is for ") -> "",
					(StartOfString ~~ "GNU" | "GCC" ~~ Whitespace) -> "",
					(paren : "(" | ")" | "[" | "]") ~~ Whitespace :> paren
				},
				IgnoreCase -> True
			],
			{} -> Missing["NotAvailable"],
			x_ :> Failure["TitleProcessing", <|"Input" -> titleContents, "Result" -> x|>]
		}
	];
	simplifiedTitleString = SimplifyTitleString[titleString];
	
	<|
		(* Temporary for troubleshooting purposes? *)
		"TitleString" -> titleString,
		"SimplifiedTitleString" -> simplifiedTitleString,
		
		"TitleURLs" -> Lookup[sownData, "URL", Missing["NotAvailable"]],
		"SizeHistory" -> Lookup[sownData, "Strike", Missing["NotAvailable"]],
		"TitleCodeSnippets" -> Lookup[sownData, "Code", Missing["NotAvailable"]],
		"Images" -> Lookup[sownData, "Image", Missing["NotAvailable"]],
		"ReportedSize" -> ExtractReportedSize[simplifiedTitleString, titleString],
		"Language" -> ExtractLanguage[simplifiedTitleString]
	|>

];

iProcessTitle[titleContents_List] := Module[
	{sowTag},
	Reap[
		FixedPoint[
			Flatten @ Replace[
				#,
				{
					XMLElement["a", atts_List, contents_List] :> (Sow[Lookup[atts, "href"], sowTag["URL"]]; contents),
					XMLElement["s" | "strike" | "del", atts_List, contents_List] :> (Sow[contents, sowTag["Strike"]]; {}),
					XMLElement["code" | "pre", atts_List, contents_List] :> (Sow[contents, sowTag["Code"]]; contents),
					XMLElement["img", atts_List, contents_List] :> (Sow[GroupBy[atts, First -> Last, Replace[{x_} :> x]], sowTag["Image"]]; contents),
					XMLElement["strong" | "sup" | "sub" | "em" | "b" | "br" | "i" | "kbd" | "span", _List, contents_List] :> contents
				},
				{1}
			] &,
			titleContents,
			8
		]
		,
		_sowTag,
		Rule[First[#1], #2] &
	]
];



End[];

EndPackage[];
