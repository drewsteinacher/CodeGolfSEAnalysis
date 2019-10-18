BeginPackage["CodeGolfSEAnalysis`GetCodeGolfMetadata`ExtractMetadata`",
	{
		"CodeGolfSEAnalysis`",
		"CodeGolfSEAnalysis`GetCodeGolfMetadata`"
	}
];

Begin["`Private`"];

ExtractMetadata[l_List] := ExtractMetadata /@ l;
ExtractMetadata[
	XMLObject["Document"][
		documentAttributes_List,
		XMLElement["html", htmlAttributes_List, {XMLElement["body", {}, contents_List]}],
		{}
	]
] := Replace[
	DeleteCases[contents, s_String /; StringMatchQ[s, Whitespace]],
	{
		
		{
			Shortest[___],
			Alternatives[
				XMLElement["h1" | "h2" | "h3", {}, titleContents_List],
				XMLElement["p", {}, {XMLElement["strong", {}, titleContents_List]}]
			],
			XMLElement["strong" | "p" | "h2" | "h3", {}, sizeContents : {___, size_String /; StringMatchQ[size, (Whitespace | "") ~~ NumberString ~~ (Whitespace | "") ~~ $CodeSizeUnitPattern ~~ Whitespace | "", IgnoreCase -> True]}],
			Shortest[___],
			Alternatives[
				XMLElement["pre" | "code", _List, codeContents_List] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]],
				XMLElement["p", _List, {XMLElement["pre" | "code", _List, codeContents_List]}] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]],
				XMLElement["div", {"class" -> "snippet", ___}, codeContents_List] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]]
			],
			Longest[___]
		} :> <|
			"Title" -> Join[titleContents, sizeContents],
			"Code" -> codeContents,
			"Format" -> "Title+Strong+Code"
		|>,
		
		{
			Shortest[___],
			XMLElement["h1" | "h2" | "h3", _List, titleContents_List],
			Shortest[___],
			Alternatives[
				XMLElement["pre" | "code", _List, codeContents_List] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]],
				XMLElement["p", _List, {XMLElement["pre" | "code", _List, codeContents_List]}] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]],
				XMLElement["div", {"class" -> "snippet", ___}, codeContents_List] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]]
			],
			Longest[___]
		} :> <|"Title" -> titleContents, "Code" -> codeContents, "Format" -> "Title+Code"|>,
		
		{
			XMLElement["p", _List, {XMLElement["strong", _List, titleContents_List]}],
			Shortest[___],
			Alternatives[
				XMLElement["pre" | "code", _List, codeContents_List] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]],
				XMLElement["p", _List, {XMLElement["pre" | "code", _List, codeContents_List]}] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]],
				XMLElement["div", {"class" -> "snippet", ___}, codeContents_List] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]]
			],
			Longest[___]
		} :> <|"Title" -> titleContents, "Code" -> codeContents, "Format" -> "P+Strong+Code:1"|>,
		
		{
			XMLElement["p", {},
				{
					XMLElement["strong", {}, titleContents_List],
					Shortest[___],
					XMLElement["code", {}, codeContents_List],
					Longest[___]
				}
			],
			___
		} :> <|"Title" -> titleContents, "Code" -> codeContents, "Format" -> "P+Strong+Code:2"|>,
		
		{
			Shortest[___],
			Alternatives[
				XMLElement["pre" | "code", _List, codeContents_List] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]],
				XMLElement["p", _List, {XMLElement["pre" | "code", _List, codeContents_List]}] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]],
				XMLElement["div", {"class" -> "snippet", ___}, codeContents_List] /; FreeQ[codeContents, XMLElement["strike" | "del", ___]]
			],
			Longest[___]
		} :> <|"Title" -> Missing["NotFound"], "Code" -> codeContents, "Format" -> "Code"|>,
		
		{
			Shortest[___],
			XMLElement["h1" | "h2", _List, titleContents_List],
			Longest[___]
		} :> <|"Title" -> Missing["NotFound"], "Code" -> Missing["NotFound"], "Format" -> "Title:1"|>,
		{
			XMLElement["p", {}, {XMLElement["strong", {}, titleContents_List]}],
			Longest[___]
		} :> <|"Title" -> Missing["NotFound"], "Code" -> Missing["NotFound"], "Format" -> "Title:2"|>,
		
		l_List :> Failure["UnknownHTMLFormat", <|"TopLevelTags" -> Cases[l, XMLElement[t_String, ___] :> t]|>]
	}
];

ExtractMetadata[___] := $Failed;

End[];

EndPackage[];
