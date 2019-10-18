BeginPackage["CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractLanguage`",
	{
		"CodeGolfSEAnalysis`",
		"CodeGolfSEAnalysis`GetCodeGolfMetadata`"
	}
];

Begin["`Private`"];

$NameToBuiltInProgrammingLanguage = GroupBy[
	EntityValue["ProgrammingLanguage", "Name", "EntityAssociation"],
	ToLowerCase /* SanitizeBadWords,
	Keys /* Counts /* ReverseSort /* Keys /* First
];

ExtractLanguage[simplifiedString_String] := With[
	{scriptLetters = DeleteCases[$ScriptLetterPattern, "\[ScriptCapitalJ]"]},
	First[
		StringCases[
			simplifiedString,
			(StartOfString | scriptLetters) ~~ language__ ~~ (scriptLetters | EndOfString) /; (Not[StringMatchQ[language, Whitespace]] && StringFreeQ[language, scriptLetters]) :> getLanguage @ FixedPoint[
				StringTrim[
					#,
					Alternatives[
						Whitespace,
						"(" | ")" | "[" | "]",
						StartOfString ~~ "in" ~~ Whitespace,
						Whitespace ~~ ReverseSortBy["REPL" | "interactive" | "script" | "program" | "macro" | "code" | "scripting" | "solution" | "<=" | ">=" | "=" | "\[Equal]" | "\[TildeTilde]" | ">" | "<" | "(" | "[" | ")" | "]" | "v", StringLength] ~~ EndOfString,
						"\[ScriptCapitalJ]",
						Whitespace ~~ "\[ScriptCapitalJ]" ~~ (Whitespace | "") ~~ ("size" | "length" | "score" | "about" | "sequence A" | "not competing" | "dock length" | "edit distance" | "distance" | (LetterCharacter ~~ (Whitespace | "") ~~ ("=" | "\[TildeTilde]"))) ~~ (Whitespace | "") ~~ EndOfString,
						Shortest[Whitespace ~~ ("cracked by" | "posted by" | "by" | "(" | "[") ~~ __ ~~ EndOfString],
						"32-bit" | "32bit" | "32 bit" | "16-bit" | "16bit" | "16 bit" | "64-bit" | "64bit" | "64 bit"
					],
					IgnoreCase -> True
				] &,
				language,
				5
			],
			1
		],
		Missing["NotFound"]
	]
];
ExtractLanguage[___] := Missing["NotFound"];

toCamelCase = Once[ResourceFunction["ToCamelCase"]] /* ToLowerCase;

getLanguage[l : {__String}] := getLanguage /@ l;
getLanguage["" | "=" | "+"] := Missing["NotFound"];
getLanguage[normalizedName_String] := Lookup[$NameToBuiltInProgrammingLanguage, normalizedName, Missing[]] // RightComposition[
	Replace[Except[_Entity] :> MyInterpreter["ProgrammingLanguage"][normalizedName]],
	Replace[Except[_Entity] -> normalizedName],
	(getLanguage[normalizedName] = createLanguageEntity[#]) &
];

createLanguageEntity[language : Entity["ProgrammingLanguage", sn_String]] := With[
	{ent = Entity["CodeGolfProgrammingLanguage", sn]},
	ent["ProgrammingLanguage"] = language;
	ent
];
createLanguageEntity[name_String] := With[
	{ent = Entity["CodeGolfProgrammingLanguage", toCamelCase[name]]},
	ent["ProgrammingLanguage"] = Missing["NotAvailable"];
	ent["Labels"] = Append[ent["Labels"], name];
	ent
];
createLanguageEntity[x_] := x;


End[];

EndPackage[];
