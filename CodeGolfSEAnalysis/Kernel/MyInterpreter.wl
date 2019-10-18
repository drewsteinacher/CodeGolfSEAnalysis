BeginPackage["CodeGolfSEAnalysis`MyInterpreter`", {"CodeGolfSEAnalysis`"}];

Begin["`Private`"];

Options[MyInterpreter] = {"MaxNumber" -> 4, "CacheFailures" -> True};
MyInterpreter[type_String, OptionsPattern[]][s_String] := Module[
	{result, max, success, cacheFailures},
	max = Replace[OptionValue["MaxNumber"], Except[_Integer] -> 5];
	cacheFailures = TrueQ @ OptionValue["CacheFailures"];
	success = False;
	Do[
		result = Interpreter[type][s];
		If[MatchQ[result, Except[_Failure]],
			success = True;
			Break[];
		];,
		{i, 1, max}
	];
	If[success || cacheFailures,
		MyInterpreter[type][s] = result;
	];
	result
];

End[];

EndPackage[];
