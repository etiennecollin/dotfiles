return {
    s({ trig = "unit"},
        fmta(
            [[
            \unit{\<>}<>
            ]],
            {
                i(1),
                i(0),
            }
        )
    ),
    s({ trig = "text"},
        fmta(
            [[
            \text{<>}<>
            ]],
            {
                i(1),
                i(0),
            }
        )
    ),
    s({ trig = "bar"},
        fmta(
            [[
            \bar{<>}<>
            ]],
            {
                i(1),
                i(0),
            }
        )
    ),
    s({ trig = "hat"},
        fmta(
            [[
            \hat{<>}<>
            ]],
            {
                i(1),
                i(0),
            }
        )
    ),
    s({ trig = "cancel"},
        fmta(
            [[
            \cancel{<>}<>
            ]],
            {
                i(1),
                i(0),
            }
        )
    ),
    s({ trig = "deriv"},
        fmta(
            [[
            \deriv[<>]{<>}<>
            ]],
            {
                i(1),
                i(2),
                i(0),
            }
        )
    ),
    s({ trig = "diff"},
        fmta(
            [[
            \diff{<>}<>
            ]],
            {
                i(1),
                i(0),
            }
        )
    ),
}
