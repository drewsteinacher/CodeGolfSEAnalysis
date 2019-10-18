Needs["CodeGolfSEAnalysis`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`"];

VerificationTest[
	GetCodeGolfMetadata[
		{
			"<h2>Java (163)</h2>
			<p>Implementing a double precision square root calculator by making use of the fast invert square root stuff from quake and a new constant for the 64bit floats. In java. Yay for verbosity.</p>
			<pre><code>public double i(double a){double b=a/2;long c=0x5fe6ec85e7de30daL-(Double.doubleToRawLongBits(a)>>1);a=Double.longBitsToDouble(c);return a*(1.5-b*a*a);};s=1/i(x);</code></pre>"
		}
	],
	{
		<|
			"Title" -> {"Java (163)"},
			"Code" -> {XMLElement["code", {}, {"public double i(double a){double b=a/2;long c=0x5fe6ec85e7de30daL-(Double.doubleToRawLongBits(a)>>1);a=Double.longBitsToDouble(c);return a*(1.5-b*a*a);};s=1/i(x);"}]},
			"Format" -> "Title+Code",
			"TitleString" -> "Java (163)",
			"SimplifiedTitleString" -> "Java (\[ScriptCapitalD]\[ScriptCapitalD]\[ScriptCapitalD])",
			"TitleURLs" -> Missing["NotAvailable"],
			"SizeHistory" -> Missing["NotAvailable"],
			"TitleCodeSnippets" -> Missing["NotAvailable"],
			"Images" -> Missing["NotAvailable"],
			"ReportedSize" -> Quantity[163, "Bytes"],
			"Language" -> Entity["CodeGolfProgrammingLanguage", "Java::6847c"],
			"CodeSnippets" -> {"public double i(double a){double b=a/2;long c=0x5fe6ec85e7de30daL-(Double.doubleToRawLongBits(a)>>1);a=Double.longBitsToDouble(c);return a*(1.5-b*a*a);};s=1/i(x);"}
		|>
	},
	TestID -> "GetCodeGolfMetadata-simple"
];