BeginPackage["CodeGolfSEAnalysis`"];

$BadWords;
SanitizeBadWords;

MyInterpreter;

GetCodeGolfMetadata;

Begin["`Private`"];

Unprotect["CodeGolfSEAnalysis`*"];
ClearAll["CodeGolfSEAnalysis`*"];
ClearAll["CodeGolfSEAnalysis`*`*"];

<<CodeGolfSEAnalysis`SanitizeBadWords`;
<<CodeGolfSEAnalysis`MyInterpreter`;

<<CodeGolfSEAnalysis`GetCodeGolfMetadata`;

SetAttributes[Evaluate[Names["GraphStore`*"]], {ReadProtected, Protected}];

End[];
EndPackage[];