Needs["CodeGolfSEAnalysis`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`"];
Needs["CodeGolfSEAnalysis`GetCodeGolfMetadata`GetXML`"];

VerificationTest[
	GetXML["<h2>Java (163)</h2>

<p>Implementing a double precision square root calculator by making use of the fast invert square root stuff from quake and a new constant for the 64bit floats. In java. Yay for verbosity.</p>

<pre><code>public double i(double a){double b=a/2;long c=0x5fe6ec85e7de30daL-(Double.doubleToRawLongBits(a)>>1);a=Double.longBitsToDouble(c);return a*(1.5-b*a*a);};s=1/i(x);
</code></pre>
"]
	,
	XMLObject[__][___]
	,
	SameTest -> MatchQ,
	TestID -> "GetXML-single-string"
];

VerificationTest[
	GetXML[
		{
			"<h2>Java (163)</h2>

<p>Implementing a double precision square root calculator by making use of the fast invert square root stuff from quake and a new constant for the 64bit floats. In java. Yay for verbosity.</p>

<pre><code>public double i(double a){double b=a/2;long c=0x5fe6ec85e7de30daL-(Double.doubleToRawLongBits(a)>>1);a=Double.longBitsToDouble(c);return a*(1.5-b*a*a);};s=1/i(x);
</code></pre>",
			"<h1>Ruby - 101 chars (without whitespace)</h1>

<pre><code>f=->l{c=Hash.new{0}
2.upto(1E4){|i|2.upto(20){|j|c[i**j]+=1}}
c.map{|k,v|v>1&&k<=l&&k||p}.compact.sort}
</code></pre>

<p>Works for <code>1 <= limit <= 100,000,000</code> within 5 seconds.</p>

<p>Test</p>

<pre><code>> f[10000]
[16, 64, 81, 256, 512, 625, 729, 1024, 1296, 2401, 4096, 6561, 10000]
</code></pre>"
		}
	]
	,
	{XMLObject[__][___], XMLObject[__][___]}
	,
	SameTest -> MatchQ,
	TestID -> "GetXML-string-list"
];