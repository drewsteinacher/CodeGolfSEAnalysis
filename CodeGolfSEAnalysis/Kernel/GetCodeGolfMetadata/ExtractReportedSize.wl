BeginPackage["CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractReportedSize`",
	{
		"CodeGolfSEAnalysis`",
		"CodeGolfSEAnalysis`GetCodeGolfMetadata`"
	}
];

Begin["`Private`"];

ExtractReportedSize[titleString_String] := ExtractReportedSize[
	SimplifyTitleString[titleString],
	titleString
];

ExtractReportedSize[simplifiedTitleString_String, titleString_String] := Replace[
	StringPosition[
		simplifiedTitleString,
		((Longest[("\[ScriptCapitalN]" ..)] | Longest[("\[ScriptCapitalD]" ..)]) ~~ (Whitespace | "") ~~ Longest["\[ScriptCapitalC]" ..]),
		1,
		Overlaps -> False
	],
	{
		{pos_List} :> ParseReportedSize @ StringTake[titleString, pos],
		{} :> Replace[
			StringPosition[simplifiedTitleString, (Longest[("\[ScriptCapitalN]" ..)] | Longest[("\[ScriptCapitalD]" ..)]), Overlaps -> False],
			{
				{___, pos_List} :> ParseReportedSize @ StringTake[titleString, pos],
				{} -> Missing["NotFound"]
			}
		]
	}
];

ParseReportedSize[s_String] := First[
	StringCases[
		StringDelete[s, ","],
		{
			StartOfString ~~ n : (DigitCharacter ..) ~~ EndOfString :> Quantity[FromDigits[n], "Bytes"],
			StartOfString ~~ n : NumberString ~~ EndOfString :> Quantity[ToExpression[n], "Bytes"],
			StartOfString ~~ n : NumberString ~~ (Whitespace | "") ~~ unit__ ~~ EndOfString :> With[
				{u = Lookup[$StringToUnit, ToLowerCase[unit], IndependentUnit[unit]]},
				Quantity[ToExpression[n], u]
			]
		},
		1
	],
	Missing["NotFound"]
];
ParseReportedSize[___] := Missing["Unknown"];


End[];

EndPackage[];
