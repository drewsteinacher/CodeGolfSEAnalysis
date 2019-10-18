Needs["CodeGolfSEAnalysis`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractMetadata`"];

VerificationTest[
	ExtractMetadata[
		XMLObject["Document"][
			{XMLObject["Declaration"]["Version" -> "1.0", "Standalone" -> "yes"]},
			XMLElement[
				"html",
				{"version" -> "-//W3C//DTD HTML 4.01 Transitional//EN", {"http://www.w3.org/2000/xmlns/", "xmlns"} -> "http://www.w3.org/1999/xhtml"},
				{
					XMLElement["body", {},
						{
							XMLElement["h2", {}, {"Java (163)"}],
							XMLElement["p", {}, {"Implementing a double precision square root calculator by making use of the fast invert square root stuff from quake and a new constant for the 64bit floats. In java. Yay for verbosity."}],
							XMLElement["pre", {},
								{
									XMLElement["code", {}, {"public double i(double a){double b=a/2;long c=0x5fe6ec85e7de30daL-(Double.doubleToRawLongBits(a)>>1);a=Double.longBitsToDouble(c);return a*(1.5-b*a*a);};s=1/i(x);"}]
								}
							]
						}
					]
				}
			],
			{}
		]
	]
	,
	<|
		"Title" -> {"Java (163)"},
		"Code" -> {XMLElement["code", {}, {"public double i(double a){double b=a/2;long c=0x5fe6ec85e7de30daL-(Double.doubleToRawLongBits(a)>>1);a=Double.longBitsToDouble(c);return a*(1.5-b*a*a);};s=1/i(x);"}]},
		"Format" -> "Title+Code"
	|>
	,
	TestID -> "ExtractMetadata-simple-1"
];