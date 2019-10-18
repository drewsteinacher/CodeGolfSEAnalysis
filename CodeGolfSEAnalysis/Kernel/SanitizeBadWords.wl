BeginPackage["CodeGolfSEAnalysis`SanitizeBadWords`", {"CodeGolfSEAnalysis`"}];

Begin["`Private`"];

(* Compressed to avoid writing them out *)
$BadWords = Uncompress @ "1:eJxTTMoPSmNmYGAoZgESPpnFJcEgRlppcnYwK5CRlFmSnBHMDmIlFpckFqUAAP+bC14=";

SanitizeBadWords[s: _String | {___String}] := StringReplace[
	s,
	badWord : Alternatives @@ $BadWords /; Not[MemberQ[StringTake[{"BitChanger", "bitChanger"}, 5], badWord]] :> StringTake[badWord, 2] <> StringRepeat["\[FreakedSmiley]", StringLength[badWord] - 2],
	IgnoreCase -> True
];

End[];

EndPackage[];
