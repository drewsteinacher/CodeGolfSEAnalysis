BeginPackage["CodeGolfSEAnalysis`"];

$BadWords;
SanitizeBadWords;

MyInterpreter;

GetCodeGolfMetadata;
GetHistoricalCodeGolfMetadata;

Begin["`Private`"];

Unprotect["CodeGolfSEAnalysis`*"];
ClearAll["CodeGolfSEAnalysis`*"];
ClearAll["CodeGolfSEAnalysis`*`*"];

<<CodeGolfSEAnalysis`SanitizeBadWords`;
<<CodeGolfSEAnalysis`MyInterpreter`;

<<CodeGolfSEAnalysis`GetCodeGolfMetadata`;

SetAttributes[Evaluate[Names["CodeGolfSEAnalysis`*"]], {ReadProtected, Protected}];

End[];
EndPackage[];