BeginPackage["CodeGolfSEAnalysis`GetCodeGolfMetadata`SimplifyTitleString`",
	{
		"CodeGolfSEAnalysis`",
		"CodeGolfSEAnalysis`GetCodeGolfMetadata`"
	}
];

Begin["`Private`"];

$SimplificiationOverrides = {
	
	(* Languages with numbers or symbols in them that would get lost during simplification *)
	"05AB1E", "99ISC",
	"PARI/GP", "MATLAB/Octave", "Octave/MATLAB",
	"T-SQL", "SWI-Prolog", "Brain-flak", "TI-Basic",
	"Help, WarDoq!",
	
	(* Numbered machine/chip names *)
	"x86", "8086", "6800", "6502", "80386",
	
	(* Common bit phrases *)
	"16bit", "16-bit", "16 bit",
	"32bit", "32-bit", "32 bit",
	"64bit", "64-bit", "64 bit",
	
	(* Common words and phrases that use separators *)
	"Self-modifying", "Binary-Encoded",
	"2-player", "4-path"
};

SimplifyTitleString[titleString_String] := Module[
	{simplified},
	
	(* Handle "number grammar" changes *)
	simplified = FixedPoint[
		StringReplace[
			#,
			{
				dc : (DigitCharacter ..) :> StringRepeat["\[ScriptCapitalD]", StringLength[dc]],
				number : (WordBoundary ~~ ("\[ScriptCapitalD]" ..) ~~ "." | "," ~~ ("\[ScriptCapitalD]" ..) ~~ WordBoundary) :> StringRepeat["\[ScriptCapitalN]", StringLength[number]],
				version : (((("\[ScriptCapitalD]" | "\[ScriptCapitalN]") ..) ~~ ("." | "p" | "v" | "x")) .. ~~ (("\[ScriptCapitalD]" | "\[ScriptCapitalN]") ..) | "x") :> StringRepeat["\[ScriptCapitalV]", StringLength[version]],
				arithmetic : (((("\[ScriptCapitalD]" ..) | ("\[ScriptCapitalN]" ..)) ~~ (Whitespace | "") ~~ ("x" | "\[Cross]" | "+" | "-" | "\[Minus]" | "/" | "\[Divide]" | "\[LongDash]" | "\[Dash]" | "-") ~~ (Whitespace | "")) .. ~~ (("\[ScriptCapitalD]" ..) | ("\[ScriptCapitalN]" ..)) ~~ (Whitespace | "") ~~ ("=" | "\[Equal]")) :> StringRepeat[ "\[ScriptCapitalA]", StringLength[arithmetic]]
			},
			IgnoreCase -> True
		] &,
		titleString,
		5
	];
	
	(* Handle other replacements *)
	simplified = FixedPoint[
		StringReplace[
			#,
			{
				before : (WordBoundary | "\[ScriptCapitalD]" | "\[ScriptCapitalN]" | DigitCharacter) ~~ unit : $CodeSizeUnitPattern ~~ (WordBoundary | "/" | "\[ScriptCapitalJ]") :> before <> StringRepeat["\[ScriptCapitalC]", StringLength[unit]],
				
				s : $SeparatorPattern :> StringRepeat["\[ScriptCapitalS]", StringLength[s]],
				
				Shortest[WordBoundary ~~ lhs__] ~~ join : ("/" | "+" | "&" | "\[ScriptCapitalS]") ~~ Shortest[rhs__ ~~ WordBoundary] /; And[
					Not[StringMatchQ[lhs, Whitespace]] && Not[StringMatchQ[rhs, Whitespace]],
					Not[join === "+" && (StringEndsQ[lhs, "+"] || StringStartsQ[rhs, "+"])],
					StringFreeQ[lhs, $ScriptLetterPattern] && StringFreeQ[rhs, $ScriptLetterPattern]
				] :> lhs <> StringRepeat["\[ScriptCapitalJ]", StringLength[join]] <> rhs
			},
			IgnoreCase -> True
		] &,
		simplified,
		5
	];
	
	(* Handle overrides *)
	Fold[
		StringReplacePart[#1, #2, StringPosition[titleString, #2, IgnoreCase -> True]] &,
		simplified,
		$SimplificiationOverrides
	]
];
SimplifyTitleString[___] := Missing["NotFound"];


End[];

EndPackage[];