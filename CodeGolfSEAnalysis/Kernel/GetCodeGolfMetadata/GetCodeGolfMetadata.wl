BeginPackage["CodeGolfSEAnalysis`GetCodeGolfMetadata`"];


$UnitToSpellings;
$CodeSizeUnitPattern;
$StringToUnit;

$ScriptLetterPattern;

$SeparatorPattern;

GetXML;

ExtractMetadata;

ProcessTitle;
SimplifyTitleString;

ExtractLanguage;

ExtractReportedSize;
ParseReportedSize;
GetCodeGolfMetadataMarkdown;

ProcessCode;

Begin["`Private`"];


$UnitToSpellings = <|
	
	"Bytes" -> {"bytes", "bytes", "b"},
	"Bits" -> {"bits", "bit"},
	
	IndependentUnit["characters"] -> {"characters.", "characters", "character.", "character", "chars.", "chars", "char.", "char"},
	
	IndependentUnit["digits"] -> {"digits", "digit"},
	IndependentUnit["terms"] -> {"terms", "term"},
	
	IndependentUnit["lines of code"] -> {"lines", "line"},
	
	(* Like moves in BrainF*** *)
	IndependentUnit["strokes"] -> {"strokes", "stroke"},
	
	(* Commonly used with vim *)
	IndependentUnit["keystrokes"] -> {"keystrokes", "key strokes", "keystroke", "key stroke"},
	
	(* Like number of evaulation steps *)
	IndependentUnit["operations"] -> {"operations", "operation", "ops", "instructions", "instruction", "steps", "step"},
	IndependentUnit["functions"] -> {"functions", "function"},
	
	IndependentUnit["languages"] -> {"languages", "language"},
	IndependentUnit["parts"] -> {"parts", "part"},
	IndependentUnit["snippets"] -> {"snippets", "snippet"},
	
	(* Used in logic simplification *)
	IndependentUnit["gates"] -> {"gates", "gate"},
	IndependentUnit["NAND gates"] -> {"NAND gates", "NAND gate", "NANDs", "NAND"},
	
	(* Codels are a unit similar to, but not identical to, pixels, that is used in Piet *)
	IndependentUnit["codels"] -> {"codels", "codel"},
	
	IndependentUnit["points"] -> {"points", "point", "pts", "pt"},
	
	(* Blytes are a unit for programming in Minecraft with redstone *)
	(* See here: https://codegolf.meta.stackexchange.com/questions/7377/programming-in-minecraft-redstone-how-to-measure-program-size/7397#7397 *)
	IndependentUnit["blytes"] -> {"blytes", "blyte"}
|>;

$CodeSizeUnitPattern = Alternatives @@ DeleteDuplicates @ ToLowerCase @ ReverseSortBy[Join @@ Values[$UnitToSpellings], StringLength];
$StringToUnit = Association @ Flatten[KeyValueMap[Thread[Rule[#2, #1]] &, $UnitToSpellings]];

$ScriptLetterPattern = "\[ScriptCapitalD]" | "\[ScriptCapitalC]" | "\[ScriptCapitalS]" | "\[ScriptCapitalV]" | "\[ScriptCapitalA]" | "\[ScriptCapitalJ]" | "\[ScriptCapitalN]";

$SeparatorPattern = "," | "-" | ":" | "--" | "\[LongDash]" | "\[Dash]" | ";";

<<CodeGolfSEAnalysis`GetCodeGolfMetadata`GetXML`;
<<CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractMetadata`;
<<CodeGolfSEAnalysis`GetCodeGolfMetadata`SimplifyTitleString`;
<<CodeGolfSEAnalysis`GetCodeGolfMetadata`ProcessTitle`;
<<CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractReportedSize`;
<<CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractLanguage`;
<<CodeGolfSEAnalysis`GetCodeGolfMetadata`ProcessCode`;


GetCodeGolfMetadata[entities: {__Entity}] := GetCodeGolfMetadata[EntityValue[entities, "Body"]];
GetCodeGolfMetadata[bodies: {___String}] := iGetCodeGolfMetadata[bodies];

iGetCodeGolfMetadata = RightComposition[
	GetXML,
	ExtractMetadata,
	Map[processMetadata]
];

processMetadata[___] := <||>;
processMetadata[a_Association] := Join[
	a,(* Temporary for troubleshooting purposes *)
	(*KeyDrop[a,{"Title","Code"}],*)
	ProcessTitle[Lookup[a, "Title"]],
	ProcessCode[Lookup[a, "Code"]]
];


GetHistoricalCodeGolfMetadata[post_Entity] := First @ GetHistoricalCodeGolfMetadata[{post}];
GetHistoricalCodeGolfMetadata[posts: {__Entity}] := iGetHistoricalCodeGolfMetadata[
	EntityValue[posts, "PostHistory", "EntityAssociation"]
];


htmlQ = StringStartsQ["<h" ~~ DigitCharacter ~~ ">"];
markdownQ = StringQ;

ClearAll[iGetHistoricalCodeGolfMetadata];
iGetHistoricalCodeGolfMetadata[postToPostHistory_Association] := Module[
	{allPostHistory, allBodyEditHistories, dates, texts, metadata, editHistoryToMetadata},
	
	allPostHistory = Cases[Values[postToPostHistory], Entity[_String, _String], Infinity];
	
	(* Keep only PostHistory entities for initial/edit body *)
	allBodyEditHistories = Pick[
		allPostHistory,
		MatchQ[Entity["StackExchange:PostHistoryType", "2"] | Entity["StackExchange:PostHistoryType", "5"]] /@ EntityValue[allPostHistory, "PostHistoryType"]
	];
	
	{dates, texts} = Transpose @ EntityValue[allBodyEditHistories, {"CreationDate", "Text"}];
	
	(* Efficiently extract metadata *)
	metadata = Fold[
		SubsetMap[#2[[2]], #1, Position[#1, _String?(#2[[1]])]] &,
		texts,
		{htmlQ -> GetCodeGolfMetadata, markdownQ -> GetCodeGolfMetadataMarkdown}
	];
	
	(* TODO: Drop the texts? Useful for troubleshooting for now though... *)
	metadata = Join[#, <|"Date" -> #2, "Text" -> #3|>]& @@@ Transpose[{metadata, dates, texts}];
	
	(* Process the metadata in the same way as non-history post metadata *)
	editHistoryToMetadata = processMetadata /@ AssociationThread[allBodyEditHistories, metadata];
	
	(* Re-attach to posts to maintain structure and make EventSeries *)
	RightComposition[
		Lookup[editHistoryToMetadata, #, <||>]&,
		Map[{#["Date"], #}&],
		Cases[{_DateObject, _Association}],
		Replace[
			{
				{} -> Missing[],
				ts_List :> EventSeries[ts]
			}
		]
	] /@ Values[postToPostHistory]
];

$CodeBlockLineSeparator = "\r\n";
$CodeBlockIndent = "    ";
$CodeBlockLineStart = ($CodeBlockLineSeparator ~~ $CodeBlockIndent);

GetCodeGolfMetadataMarkdown[texts_List] := GetCodeGolfMetadataMarkdown /@ texts;
GetCodeGolfMetadataMarkdown[text_String] := With[
	{
		titleString = First[
			StringCases[
				text,
				Shortest[StartOfLine | StartOfString ~~ ("###" | "##" | "#") ~~ (Whitespace | "") ~~ title__ ~~ EndOfLine] :> title,
				1
			],
			First[
				StringCases[
					text,
					Shortest[
						StartOfString ~~ title__ ~~ (Whitespace | "") ~~ "\n" ~~ ("-" ..) ~~ Whitespace | "" ~~ EndOfLine
					] /; StringFreeQ[title, "\n"] :> StringTrim[title, Whitespace],
					1
				],
				Missing["NotFound"]
			]
		],
		codeBlocks =
			StringCases[
				text,
				StringExpression[
					$CodeBlockLineSeparator,
					lines : Shortest[$CodeBlockLineStart, __] ..,
					$CodeBlockLineSeparator
				] :> StringReplace[lines, $CodeBlockLineStart -> "\n"]
			]
	},
	<|
		"Title" -> Replace[
			titleString,
			s_String :> {
				StringReplace[StringTrim @ s,
					{
						Shortest["<" ~~ tag:"strike" | "del" | "s" ~~ ">" ~~ __ ~~ "</" ~~ tag__ ~~ ">"] -> "",
						Shortest["<" ~~ ("/" | "") ~~ __ ~~ ">"] -> ""
					}
				]
			}
		],
		"Code" -> codeBlocks,
		"Format" -> "Markdown"
	|>
];

End[];

EndPackage[];
