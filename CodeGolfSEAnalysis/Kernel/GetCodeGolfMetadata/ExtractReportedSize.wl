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


htmlQ = StringStartsQ["<h" ~~ DigitCharacter ~~ ">"];
markdownQ = StringStartsQ["#"];

(* TODO: Extend to get all usual metadata for all post history entities? *)
ExtractReportedSizeForPostHistory[texts_List] := With[
	{
		textToMetadata = Join[
			AssociationThread[# -> Lookup[GetCodeGolfMetadata[#], "ReportedSize", Missing["NotFound"]]] &[Pick[texts, htmlQ[texts]]],
			AssociationMap[ExtractReportedSizeMarkdown, Pick[texts, markdownQ[texts]]]
		]
	},
	Lookup[textToMetadata, texts]
];


ExtractReportedSizeMarkdown[text_String] := With[
	{
		titleString = First[
			StringCases[
				text,
				Shortest[StartOfLine | StartOfString ~~ ("###" | "##" | "#") ~~ (Whitespace | "") ~~ title__ ~~ EndOfLine] :> title,
				1
			],
			Missing["NotFound"]
		]
	},
	Replace[
		titleString,
		{
			title_String :> ExtractReportedSize[title],
			m_Missing :> m
		}
	]
];


End[];

EndPackage[];
