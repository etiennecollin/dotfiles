local tex_utils = require("etiennecollin.snippets.tex.utils")

return {
	s(
		{ trig = "example" },
		fmta(
			[[
            \begin{example}{<>}
                <>
            \end{example}
            ]],
			{
				i(1),
				i(0),
			}
		)
	),
	s(
		{ trig = "subexample" },
		fmta(
			[[
            \begin{subexample}{<>}
                <>
            \end{subexample}
            ]],
			{
				i(1),
				i(0),
			}
		),
		{ condition = tex_utils.in_env("example") }
	),
	s(
		{ trig = "exercise" },
		fmta(
			[[
            \begin{exercise}{<>}
                <>
            \end{exercise}
            ]],
			{
				i(1),
				i(0),
			}
		)
	),
	s(
		{ trig = "subexercise" },
		fmta(
			[[
            \begin{subexercise}{<>}
                <>
            \end{subexercise}
            ]],
			{
				i(1),
				i(0),
			}
		),
		{ condition = tex_utils.in_env("exercise") }
	),
	s(
		{ trig = "es" },
		fmta(
			[[
            \[
                \begin{split}
                    <>
                \end{split}
            \]
            ]],
			{
				i(0),
			}
		)
	),
	s(
		{ trig = "amat" },
		fmta(
			[[
            \begin{amatrix}{<>}
                <>
            \end{amatrix}
            ]],
			{
				i(1),
				i(0),
			}
		)
	),
}
