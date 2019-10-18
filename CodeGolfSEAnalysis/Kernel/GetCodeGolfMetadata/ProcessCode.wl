BeginPackage["CodeGolfSEAnalysis`GetCodeGolfMetadata`ProcessCode`",
	{
		"CodeGolfSEAnalysis`",
		"CodeGolfSEAnalysis`GetCodeGolfMetadata`"
	}
];

Begin["`Private`"];

ProcessCode[___] := <||>;
ProcessCode[codeContents_List] := With[
	{
		fixedSnippets = FixedPoint[
			Replace[
				#,
				{
					XMLElement["code", {}, {}] -> Nothing,
					XMLElement["strike", {}, _] -> Nothing,
					XMLElement["code", {}, {XMLElement["del", _List, _]}] -> Nothing,
					XMLElement["code", _List, {c_String} | c_String] :> c,
					XMLElement["code", atts_List, contents : {_String, __String}] :> XMLElement["code", atts, StringJoin @@ contents],
					XMLElement["code", atts_List, contents : {_, __}] :> XMLElement[
						"code",
						atts,
						Flatten @ ReplaceAll[
							contents,
							{
								XMLElement["del" | "strike", {}, _] -> {},
								XMLElement[x_String, {y_String -> y_String}, {}] :> {"<" <> x <> ", " <> y <> ">"},
								XMLElement["br", {"clear" -> "none"}, {}] :> "<br/>",
								XMLElement["b", {}, {s_String}] :> s,
								XMLElement[x_String, {}, {}] :> {"<" <> x <> ">"}
							}
						]
					]
					
				},
				{1}
			] &,
			codeContents,
			120
		]
	},
	<|"CodeSnippets" -> fixedSnippets|>
];

End[];

EndPackage[];
