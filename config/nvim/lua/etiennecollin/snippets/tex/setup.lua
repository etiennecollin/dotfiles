local tex_utils = require("etiennecollin.config.luasnip")

return {
    s(
        {trig = "setup"},
        fmta(
            [[
            \input{/Users/etiennecollin/github/latex-templates/paths}
            \path{macOS}

            \documentclass[12pt]{article}
            \usepackage[english]{babel}
            \usepackage{\basepath/packages}
            \usepackage[style=ieee,backref=true,backend=biber,date=iso,datezeros=true,seconds=true]{biblatex}

            % DOCUMENT USER SETTINGS ==============================================================================================
            \newcommand{\docAuthorName}{Etienne Collin}
            \newcommand{\docAuthorStudentNumber}{2038029}
            \newcommand{\docAuthorTitlePage}{\docAuthorName\ - \docAuthorStudentNumber}
            \newcommand{\docClass}{<>}
            \newcommand{\docClassInstructor}{Professor <>}
            \newcommand{\docClassNumber}{<>}
            \newcommand{\docClassSection}{<>}
            \newcommand{\docClassSemester}{<>}
            \newcommand{\docDueDate}{<>}
            \newcommand{\docDueTime}{<>}
            \newcommand{\docSubtitle}{<>}
            \newcommand{\docTitle}{<>}
            \input{\template/basic/page_settings}       % Imports custom page settings
            \input{\template/basic/environment}         % Imports custom environments and definitions

            % \fancyhf[HR]{\docClassTime}				% Removes student number from right header

            % SOURCE ==============================================================================================================
            \begin{document}
            \input{\template/basic/title_page_udem}

            % START OF DOCUMENT ===================================================================================================

            \subfile{subfiles/<>}

            % END OF DOCUMENT =====================================================================================================
            % % List of figures/tables
            % \pagebreak
            % \begin{appendix}
            % 	\phantomsection\listoffigures
            % 	\phantomsection\listoftables
            % \end{appendix}

            \pagebreak\phantomsection\printbibliography[heading=bibintoc]
            %\nocite{}
            \end{document}
            ]],
            {
                i(1, "Class name"),
                i(2, "Professor name"),
                i(3, "Class number"),
                i(4, "Class section"),
                i(5, "Class semester"),
                i(6, "Due date"),
                i(7, "Due time"),
                i(8, "Doc Subtitle "),
                i(9, "Doc Title"),
                i(0, "subfile_01")
            }
        ),
        { condition = tex_utils.in_text and tex_utils.begins_line }
    ),
    s(
        {trig = "subsetup"},
        fmta(
            [[
            \documentclass[../<>]{subfiles}
            \begin{document}
            <>
            \end{document}
            ]],
            {
                i(1, "main.tex"),
                i(0, "Content"),
            }
        ),
        { condition = tex_utils.in_text and tex_utils.begins_line }
    )
}