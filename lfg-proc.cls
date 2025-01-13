\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lfg-proc}[2024/12/06 Class for LFG Proceedings papers v0.3]

\DeclareOption{10pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{letterpaper}{\OptionNotUsed}
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}

% Use linguex, but declare it last because it doesn't play nicely with tipa
\DeclareOption{linguex}{\AtEndOfClass{%
	\RequirePackage{linguex}}
  % Command to right-align language name with linguex glossed examples; from
  % https://brianbuccola.com/right-aligned-text-in-a-linguex-gloss-example/
  \newcommand{\exlang}[1]{\hfill\raisebox{1.9\baselineskip}[0pt][0pt]{(#1)}}
}

% Use tipa; we assume you want this unless you explicitly say not with the notipa option
\newif\if@tipa
\@tipatrue
\DeclareOption{notipa}{\@tipafalse}

% Pass all unknown options to the article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% Process options
\ProcessOptions\relax

% Load tipa if notipa is not set
\if@tipa \RequirePackage{tipa} \fi

% \usepackage[showframe]{geometry}
\LoadClass[11pt,a4paper,fleqn,notitlepage]{article}
% \LoadClass[11pt,letter,fleqn,notitlepage]{article}

% MB: could use these margins instead of sticking to a4
\setlength{\textwidth}{6.5in}
\setlength{\oddsidemargin}{0in}
% \setlength{\topmargin}{-.25in}
% \setlength{\textheight}{9in}

% Times font
\RequirePackage{times}

% Natbib settings
\RequirePackage[sectionbib]{natbib}
\bibpunct{(}{)}{;}{a}{}{,}
\setcitestyle{notesep={:~}} % Changes separator between year and page to colon

% Spacing in bibliography
% \setlength{\bibsep}{0.3pt}

% Hyperlink settings
\RequirePackage[hyphens]{url}
%
\urlstyle{same}
\RequirePackage{xcolor}
\definecolor{hlinkcolor}{rgb}{.0,.2,.4} % A nice dark blue
%
\RequirePackage[%
	bookmarks=true,
	bookmarksopen=true,
	hyperindex=true,
	breaklinks=true,
	draft=false,
	plainpages=false,
	hyperfootnotes=false,
	colorlinks=true,
	urlcolor=hlinkcolor,
	pdfborder={0 0 0},
	linkcolor = black,% For internal links
	citecolor = black% For citation links
	]{hyperref}

\RequirePackage[margin=1.5in]{geometry}

% No page numbers
\pagestyle{empty}

% Single spacing after full stops
\frenchspacing

% Command to print two-digit year
\newcommand*\shortyear{\expandafter\@gobbletwo\number\numexpr\year\relax}


%==== Author names and affiliations ===============

\RequirePackage{pbox}

% Command for affiliations so that authors' names align properly
\newcommand{\affiliation}[1]{\\\small
	\pbox[t]{0.33\textwidth}{\relax\ifvmode\centering\fi#1}%
}

% Begin author block
\newcommand{\startauthorblock}{%
  \begin{tabular}[t]{c}}
% End author block
\newcommand{\stopauthorblock}{%
  \end{tabular}}

% Modified version of \and to include these macros
\renewcommand\and{%
  \stopauthorblock%
  \hskip 2em \@plus.17fil%
  \startauthorblock }

% Messing with lineskip and lineskiplimit, so save the defaults to restore after:
\newlength{\defaultlineskip}
% \newlength{\defaultlineskiplimit}
\setlength{\defaultlineskip}{\lineskip}
% \setlength{\defaultlineskiplimit}{\lineskiplimit}

% Set the new values for dealing with author block spacing:
\setlength{\lineskip}{1.5em} % Increase spacing for when author block tabulars wrap to a new line
% \setlength{\lineskiplimit}{0pt} % Allow spacing to apply when dealing with floats like tabulars -- works without for now, but leaving in for future reference.

%===============================================================================
% Our own title page

\renewcommand{\maketitle}{%
\hspace{0pt}
\vfill

\begin{center}
\Large
		{\huge\bf \@title\par}\vspace{\baselineskip}

% Process author blocks
\startauthorblock
	\@author
\stopauthorblock%
%
% \\[5\baselineskip]
\vfill
\large
	Proceedings of the LFG'\shortyear{} Conference\\[\baselineskip]

  Miriam Butt,  Jamie Y. Findlay  and Ida Toivonen  (Editors)\\[\baselineskip]


	\the\year{}\\[\baselineskip]

	PubliKon\\[\baselineskip]

	% \url{https://lfg-proceedings.org}
	 \href{https://lfg-proceedings.org}{lfg-proceedings.org}

\end{center}

% \vfill

% Restore original values of lineskip and lineskiplimit:
\setlength{\lineskip}{\defaultlineskip}
% \setlength{\lineskiplimit}{\defaultlineskiplimit}

\newpage
}
%===============================================================================

% Acknowledgements footnote
\newcommand{\acknowledgements}[1]{%
\setcounter{footnote}{1}%
\renewcommand{\thefootnote}{\fnsymbol{footnote}}%
\footnote{%
  #1
}%
\renewcommand{\thefootnote}{\arabic{footnote}}%
\setcounter{footnote}{0}%
}
