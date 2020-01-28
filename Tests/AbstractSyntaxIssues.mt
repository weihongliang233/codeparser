
Needs["CodeParser`"]

(*
Package:
*)

TestMatch[
	FirstCase[CodeParse["BeginPackage[\"Foo`\"]", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["Package", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-P2N0D7"
]

TestMatch[
	FirstCase[CodeParse["EndPackage[]", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["Package", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-M6K6Y5"
]

TestMatch[
	FirstCase[CodeParse["Begin[\"Foo`\"]", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["Package", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-F7B2Y5"
]

TestMatch[
	FirstCase[CodeParse["End[]", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["Package", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-T0U9L8"
]








(*
StrangeCall:
*)

TestMatch[
	FirstCase[CodeParse["a;b;[]", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCall", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-T2E6L3"
]

TestMatch[
	FirstCase[CodeParse["a;b;[];c", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCall", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-Z2Y3I1"
]

TestMatch[
	FirstCase[CodeParse[" a;b;\[LeftDoubleBracket]\[RightDoubleBracket] ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCall", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-P6P7U2"
]

TestMatch[
	FirstCase[CodeParse[" a;b;\[LeftDoubleBracket]\[RightDoubleBracket];c ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCall", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-S6O1O1"
]

TestMatch[
	FirstCase[CodeParse[" %[] ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCall", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-X5H0W9"
]

TestMatch[
	FirstCase[CodeParse[" \\!\\(x\\)[] ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCall", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-V9T6S1"
]

TestMatch[
	FirstCase[CodeParse[" \\(x\\)[] ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCall", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-I7T4W0"
]


TestMatch[
	FirstCase[CodeParse[" x--[] ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCall", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-I3X6I7"
]







(*
SyntaxUndocumentedMessageName:
*)

TestMatch[
	FirstCase[CodeParse[" a::b::c::d ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["SyntaxUndocumentedMessageName", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-F4W6X1"
]








(*
Comma:
*)


TestMatch[
	FirstCase[CodeParse[" f[1,2,] ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["Comma", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-V4Q1U5"
]

TestMatch[
	CodeParse[" f[,1] "]
	,
	ContainerNode[String, {
		CallNode[LeafNode[Symbol, "f", _], {
			LeafNode[Symbol, "Null", KeyValuePattern[AbstractSyntaxIssues -> _]],
			LeafNode[Integer, "1", _]}, _] }, _]
	,
	TestID->"AbstractSyntaxIssues-20190520-V9J1I3"
]








(*
StrangeCallSlotSequence:
*)

TestMatch[
	FirstCase[CodeParse[" ##2[] ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {SyntaxIssue["StrangeCallSlotSequence", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-O7G6C1"
]





(*
NotContiguous:
*)


TestMatch[
	FirstCase[CodeParse[" a[[] ] ", ContainerNode[Hold, #[[1]], <||>] &],
		KeyValuePattern[AbstractSyntaxIssues -> _], $Failed, {0, Infinity}]
	,
	KeyValuePattern[AbstractSyntaxIssues -> {FormatIssue["NotContiguous", _, _, _]}]
	,
	TestID->"AbstractSyntaxIssues-20190520-U1R2G5"
]







