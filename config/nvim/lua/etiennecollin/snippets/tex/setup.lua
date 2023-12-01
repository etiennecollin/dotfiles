local tex_utils = require("etiennecollin.snippets.tex.utils")

return {
	s(
		{ trig = "setup" },
		fmta(
			[[
            \newcommand{\latexTemplatesPath}{/absolute/path/to/latex-templates}

            \documentclass[12pt]{article}
            \usepackage[english]{babel}
            \usepackage{\latexTemplatesPath/packages}
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
            \input{\latexTemplatesPath/templates/basic/page_settings}       % Imports custom page settings
            \input{\latexTemplatesPath/templates/basic/environment}         % Imports custom environments and definitions
            % \fancyhf[HR]{\docClassTime}                                   % Removes student number from right header

            % SOURCE ==============================================================================================================
            \begin{document}
            \input{\latexTemplatesPath/templates/basic/title_page_udem}

            % \todototoc
            % \listoftodos
            % \pagebreak

            % START OF DOCUMENT ===================================================================================================
            % \subfile{subfiles/...}

            <>

            % END OF DOCUMENT =====================================================================================================
            % % List of figures/tables
            % \pagebreak
            % \begin{appendix}
            %     \phantomsection\listoffigures
            %     \phantomsection\listoftables
            % \end{appendix}

            \pagebreak\phantomsection\printbibliography[heading=bibintoc]
            %\nocite{}
            \end{document}
            ]],
			{
				i(1, "Class name"),
				i(5, "Professor name"),
				i(2, "Class number"),
				i(3, "Class section"),
				i(4, "Class semester"),
				i(8, "Due date"),
				i(9, "23:59"),
				i(7, "Doc Subtitle "),
				i(6, "Doc Title"),
				i(0, "CONTENT HERE"),
			}
		),
		{ condition = tex_utils.in_text and tex_utils.begins_line }
	),
	s(
		{ trig = "subsetup" },
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
	),
}
