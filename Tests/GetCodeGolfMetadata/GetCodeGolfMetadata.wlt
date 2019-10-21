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

VerificationTest[
	GetCodeGolfMetadataMarkdown["#Mathematica 105\r\n\r\n    l = Length; Cases[Range@9867312,n_ /;(FreeQ[i=IntegerDigits@n, 0]&&l@i== l@Union@i&&And @@(Divisible[n,#]&/@i))]"],
	<|"Title" -> {"Mathematica 105"}, "Code" -> {}, "Format" -> "Markdown"|>,
	TestID -> "GetCodeGolfMetadataMarkdown-simple"
];

VerificationTest[
	GetCodeGolfMetadataMarkdown["# PHP - <s>54</s> 48 characters\r\n\r\n    <?for($s=`cat`;$s!=$r=strrev($s);$s+=$r);echo$s;\r\n\r\nTest:\r\n\r\n    $ php 196.php <<< 5280\r\n    23232"],
	<|
		"Title" -> {"PHP -  48 characters"},
		"Code" -> {"\n<?for($s=`cat`;$s!=$r=strrev($s);$s+=$r);echo$s;", "\n$ php 196.php <<< 5280"},
		"Format" -> "Markdown"
	|>,
	TestID -> "GetCodeGolfMetadataMarkdown-with-strikes"
];

VerificationTest[
	CodeGolfSEAnalysis`GetCodeGolfMetadata`GetCodeGolfMetadataMarkdown["C# - <strike>103</strike> 99 chars\r\n---\r\n\r\n    public int P(int i)\r\n    {\r\n        var r = int.Parse(new string(i.ToString().Reverse().ToArray())));\r\n        return r == i ? i : P(i + r);        \r\n    }\r\n\r\nC# never does very well in golf. Elegant, but verbose.\r\n"],
	<|
		"Title" -> {"C# -  99 chars"},
		"Code" -> {"\npublic int P(int i)\n{\n    var r = int.Parse(new string(i.ToString().Reverse().ToArray())));\n    return r == i ? i : P(i + r);        \n}"},
		"Format" -> "Markdown"
	|>,
	TestID -> "GetCodeGolfMetadataMarkdown-with-title-divider"
];