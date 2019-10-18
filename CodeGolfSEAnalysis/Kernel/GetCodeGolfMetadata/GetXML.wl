BeginPackage["CodeGolfSEAnalysis`GetCodeGolfMetadata`GetXML`",
	{
		"CodeGolfSEAnalysis`",
		"CodeGolfSEAnalysis`GetCodeGolfMetadata`"
	}
];


Begin["`Private`"];

iGetXML = ImportString["<html>" <> # <> "</html>", "XMLObject"] &;

GetXML[body_String] := First @ GetXML[{body}];
GetXML[{}] := {};
GetXML[bodies : {__String}] := Quiet[
	With[
		{
			fixedBodies = StringReplace[
				bodies,
				{
					"\[SpaceIndicator]" -> "_",
					"php:" -> "php :",
					"<math.h>" -> "<Math.h>",
					"<>" -> "&lt;&gt;",
					"<<" -> "&lt;&lt;",
					"<- " -> "&lt;- ",
					"<= " ~~ n : DigitCharacter :> "&lt;= " <> n,
					"?<" ~~ n : DigitCharacter :> "?&lt;" <> n,
					"<" ~~ n : DigitCharacter .. ~~ ">" :> "&lt;" <> n <> "&gt;"
				}
			],
			parallelize = If[Length[bodies] > 100,
				Parallelize,
				Identity
			]
		},
		parallelize[iGetXML /@ fixedBodies]
	]
];

End[];


EndPackage[];
