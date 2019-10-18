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
ExtractReportedSizeForPostHistory;
ExtractReportedSizeMarkdown;

ProcessCode;

Begin["`Private`"];


$UnitToSpellings = <|
	
	(* TODO: Decide if characters should be separated from bytes? *)
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


End[];

EndPackage[];
