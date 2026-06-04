%% ncitproject.cls
%% Nepal College of Information Technology — Academic Project Guidelines 2019
%% Report formatting for Project I / II (Minor) / III (Major): Proposal, Mid-term, Final
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ncitproject}[2019/05/24 NCIT Academic Project Report Class]

\LoadClass[12pt,a4paper,oneside]{article}

% ---------------------------------------------------------------------------
% Class options
% ---------------------------------------------------------------------------
\newif\if@ncitproposal
\newif\if@ncitmidterm
\newif\if@ncitfinal
\newif\if@ncitmajor
\newif\if@ncitminor
\newif\if@ncitfirst

\DeclareOption{proposal}{\@ncitproposaltrue}
\DeclareOption{midterm}{\@ncitmidtermtrue}
\DeclareOption{final}{\@ncitfinaltrue}
\DeclareOption{major}{\@ncitmajortrue}
\DeclareOption{minor}{\@ncitminortrue}
\DeclareOption{first}{\@ncitfirsttrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\if@ncitproposal\else
  \if@ncitmidterm\else
    \if@ncitfinal\else
      \@ncitproposaltrue
    \fi
  \fi
\fi

\if@ncitmajor\else
  \if@ncitminor\else
    \if@ncitfirst\else
      \@ncitmajortrue
    \fi
  \fi
\fi

% ---------------------------------------------------------------------------
% Fonts — Times New Roman 12 pt (guideline); Arial Black 20 pt college banner
% ---------------------------------------------------------------------------
\RequirePackage{iftex}
\ifXeTeX
  \RequirePackage{fontspec}
  \setmainfont{Times New Roman}[
    Ligatures=TeX,
    Scale=1.0,
  ]
  \newcommand{\ncit@collegefont}{%
    \fontspec{Arial Black}\fontsize{20}{24}\selectfont}%
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{mathptmx}
  \RequirePackage{microtype}
  \newcommand{\ncit@collegefont}{%
    \fontfamily{ptm}\bfseries\fontsize{20}{24}\selectfont}%
\fi
\ifPDFTeX
  \RequirePackage{microtype}
\fi

% ---------------------------------------------------------------------------
% Page layout — A4, 1" margins + 0.5" binding (gutter) on the left
% ---------------------------------------------------------------------------
\RequirePackage{geometry}
\geometry{
  a4paper,
  portrait,
  left=1in,
  right=1in,
  top=1in,
  bottom=1in,
  bindingoffset=0.5in
}

% ---------------------------------------------------------------------------
% Spacing — 1.5 lines; 6 pt before/after paragraphs
% ---------------------------------------------------------------------------
\RequirePackage{setspace}
\onehalfspacing
\RequirePackage[skip=6pt]{parskip}
\setlength{\parindent}{0pt}

% ---------------------------------------------------------------------------
% Headers and footers (Guidelines 2019: project title; [page/total] centred)
% ---------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}

\AtEndDocument{\label{LastPage}}
\newcommand{\ncit@pageoftotal}{%
  [\thepage/\pageref{LastPage}]%
}

\newcommand{\ncit@projecttitle}{}
\newcommand{\ProjectTitle}[1]{%
  \renewcommand{\ncit@title}{#1}%
  \renewcommand{\ncit@projecttitle}{#1}%
}
\newcommand{\ProjectHeaderTitle}[1]{\renewcommand{\ncit@projecttitle}{#1}}

\setlength{\headheight}{14pt}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\small\ncit@projecttitle}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[C]{\small\ncit@pageoftotal}
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyhead[C]{\small\ncit@projecttitle}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[C]{\small\ncit@pageoftotal}
}

% ---------------------------------------------------------------------------
% Section numbering (legal / decimal style) and new page per section
% ---------------------------------------------------------------------------
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}

% Final/mid-term: each section on a new page (Guidelines 2019).
% Proposal: continuous flow to stay within the 8--10 page limit (references in
% Refrence_pdf_projects_old/ are final reports, not proposal samples).
\if@ncitproposal\else
  \pretocmd{\section}{\clearpage}{}{}
\fi

% Heading sizes: stepwise above 12 pt body, below title (~14 pt cap)
\makeatletter
\renewcommand\section{\@startsection{section}{1}{\z@}% 
  {-6pt \@plus -2pt \@minus -2pt}{6pt \@plus 2pt}%
  {\normalfont\large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-6pt \@plus -2pt \@minus -2pt}{6pt \@plus 2pt}%
  {\normalfont\normalsize\bfseries\itshape}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-6pt \@plus -2pt \@minus -2pt}{6pt \@plus 2pt}%
  {\normalfont\normalsize\itshape}}
\if@ncitproposal
  \renewcommand\section{\@startsection{section}{1}{\z@}%
    {-4pt \@plus -1pt \@minus -1pt}{4pt \@plus 1pt}%
    {\normalfont\large\bfseries}}
\fi

% ---------------------------------------------------------------------------
% Figures, tables, equations (centred; captions; equation numbers right)
% ---------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{amsmath,amssymb}
\RequirePackage{caption}
\RequirePackage{subcaption}

% ---------------------------------------------------------------------------
% UML diagrams — inline (non-floating) so they never move below References
% ---------------------------------------------------------------------------
\newcommand{\uml@include}[2]{%
  \IfFileExists{figures/uml/#1.pdf}{%
    \includegraphics[#2,keepaspectratio]{figures/uml/#1}}{%
    \IfFileExists{figures/uml/#1.png}{%
      \includegraphics[#2,keepaspectratio]{figures/uml/#1}}{%
      \fbox{\parbox[c][0.12\textheight][c]{0.9\linewidth}{\centering\small Missing #1}}}}%
}
% \umlfigure[width factor]{label}{basename}{caption}
\newcommand{\umlfigure}[4][1.0]{%
  \par\vspace{0.2em}%
  \begin{center}%
    \if@ncitproposal
      \uml@include{#3}{width=#1\linewidth,height=0.28\textheight}%
    \else
      \uml@include{#3}{width=#1\linewidth,height=0.15\textheight}%
    \fi
  \end{center}%
  \vspace{0.1em}%
  \captionof{figure}{#4}%
  \label{fig:#2}%
  \par\vspace{0.2em}%
}
\captionsetup{
  font=small,
  labelfont=bf,
  justification=centering,
  singlelinecheck=false
}
\captionsetup[table]{position=below, skip=0.5em}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
% ---------------------------------------------------------------------------
% Citations and hyperlinks (clickable [1], [2], … to bibliography)
% ---------------------------------------------------------------------------
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  urlcolor=blue,
  citecolor=black,
  breaklinks=true,
  pdfauthor={NCIT Project Report}
}

% ---------------------------------------------------------------------------
% Page numbering (Guidelines 2019)
% Roman (I, II, III…): front matter through List of Tables/Figures
% Arabic (1, 2, 3…): main report body from first numbered section onward
% ---------------------------------------------------------------------------
\newcommand{\frontmatter}{%
  \clearpage
  \pagenumbering{roman}%
  \setcounter{page}{1}%
  \renewcommand{\thepage}{\Roman{page}}%
}
\newcommand{\mainmatter}{%
  \clearpage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
  \renewcommand{\thepage}{\arabic{page}}%
}

% ---------------------------------------------------------------------------
% Metadata commands (title page — Appendix A)
% ---------------------------------------------------------------------------
\newcommand{\ncit@reportstage}{Proposal}
\newcommand{\ncit@projectkind}{Major}
\newcommand{\ncit@title}{Project Title}
\newcommand{\ncit@degree}{Bachelor of Engineering in Computer Engineering}
\newcommand{\ncit@department}{Computer Engineering}
\newcommand{\ncit@supervisor}{Supervisor Name}
\newcommand{\ncit@supervisordesignation}{}
\newcommand{\ncit@date}{\today}

\newcommand{\ReportStage}[1]{\renewcommand{\ncit@reportstage}{#1}}
\newcommand{\ProjectKind}[1]{\renewcommand{\ncit@projectkind}{#1}}
\newcommand{\DegreeName}[1]{\renewcommand{\ncit@degree}{#1}}
\newcommand{\DepartmentName}[1]{\renewcommand{\ncit@department}{#1}}
\newcommand{\SupervisorName}[1]{\renewcommand{\ncit@supervisor}{#1}}
\newcommand{\SupervisorDesignation}[1]{\renewcommand{\ncit@supervisordesignation}{#1}}
\newcommand{\SubmissionDate}[1]{\renewcommand{\ncit@date}{#1}}

\def\ncit@setstage{%
  \if@ncitproposal\ReportStage{Proposal}\fi
  \if@ncitmidterm\ReportStage{Mid-term}\fi
  \if@ncitfinal\ReportStage{Final}\fi
  \if@ncitmajor\ProjectKind{Major}\fi
  \if@ncitminor\ProjectKind{Minor}\fi
  \if@ncitfirst\ProjectKind{First}\fi
}

\newcommand{\ncit@students}{%
  Student Name, Roll No. XXXXXX \\
}

\newcommand{\SetStudents}[1]{\renewcommand{\ncit@students}{#1}}
\newcommand{\AddStudent}[2]{%
  \g@addto@macro\ncit@students{#1 & #2 \\}%
}

\newcommand{\ncit@collegelogo}{college_logo.png}
\newcommand{\CollegeLogo}[1]{\renewcommand{\ncit@collegelogo}{#1}}

% NCIT letterhead block (logo left, department + college name right — college sample)
\newcommand{\ncit@collegefooter}{%
  \noindent
  \begin{minipage}[c]{0.24\textwidth}
    \centering
    \IfFileExists{\ncit@collegelogo}{%
      \includegraphics[height=2.4cm,keepaspectratio]{\ncit@collegelogo}}{%
      \fbox{\parbox[c][2.5cm][c]{0.9\linewidth}{\centering\small Logo}}}%
  \end{minipage}%
  \hfill
  \begin{minipage}[c]{0.73\textwidth}
    {\fontsize{14}{17}\bfseries Department of \ncit@department\par}
    \vspace{0.4em}
    {\ncit@collegefont NEPAL COLLEGE OF\par}
    \vspace{0.15em}
    {\ncit@collegefont\underline{INFORMATION TECHNOLOGY}\par}
    \vspace{0.4em}
    {\fontsize{14}{18}\selectfont Balkumari, Lalitpur, Nepal.}%
  \end{minipage}%
}

\newcommand{\maketitlepage}{%
  \ncit@setstage
  \begin{titlepage}
    \thispagestyle{empty}
    \centering
    \vspace*{0.5cm}
    {\fontsize{14}{18}\selectfont
      A \ncit@projectkind\ Project \ncit@reportstage\ Report on\\[0.65em]
      {\fontsize{16}{20}\bfseries\selectfont \ncit@title}\\[1.2em]
      Submitted in Partial Fulfillment of the Requirements for\\[0.35em]
      the Degree of \textbf{\ncit@degree}\\[0.25em]
      under Pokhara University\\[1.2em]
      Submitted by:\\[0.4em]
      \begin{tabular}{@{}c@{}}
        \ncit@students
      \end{tabular}\\[1.2em]
      \if@ncitproposal
        Date:\\
        \ncit@date\\[1em]
      \else
        Under the supervision of\\[0.5em]
        \textbf{\ncit@supervisor}\\
        \ncit@supervisordesignation\\[2em]
        Date:\\
        \ncit@date\\[2em]
        Department of \textbf{\ncit@department}\\[2em]
      \fi
    }
    \vfill
    \ncit@collegefooter
    \vspace{0.25cm}
  \end{titlepage}
}

% ---------------------------------------------------------------------------
% Abstract with keywords (max 250 words — guideline)
% ---------------------------------------------------------------------------
\newcommand{\ncit@keywords}{}
\newcommand{\Keywords}[1]{\renewcommand{\ncit@keywords}{#1}}

\newenvironment{ncitabstract}{%
  \clearpage
  \pagenumbering{roman}%
  \setcounter{page}{1}%
  \renewcommand{\thepage}{\Roman{page}}%
  \pagestyle{fancy}
  \begin{center}
    {\bfseries ABSTRACT}
  \end{center}
  \vspace{0.35em}
  \noindent
}{%
  \par\vspace{0.8em}%
  \noindent\textbf{Keywords:} \ncit@keywords
  \phantomsection
  \addcontentsline{toc}{section}{Abstract}%
}

% List of Figures, List of Tables, Table of Contents (Roman page numbers in footer)
\newcommand{\ncit@frontlisttitle}[1]{%
  \begin{center}{\bfseries\Large #1}\end{center}%
  \vspace{0.25em}%
}
\renewcommand{\listoffigures}{%
  \vspace{1em}%
  \ncit@frontlisttitle{\listfigurename}%
  \begingroup\small
  \@starttoc{lof}%
  \endgroup
}
\renewcommand{\listoftables}{%
  \vspace{1em}%
  \ncit@frontlisttitle{\listtablename}%
  \begingroup\small
  \@starttoc{lot}%
  \endgroup
}
\renewcommand{\tableofcontents}{%
  \clearpage
  \ncit@frontlisttitle{\contentsname}%
  \begingroup\small
  \@starttoc{toc}%
  \endgroup
}
\newcommand{\ncitprintfrontmatter}{%
  \tableofcontents
  \listoftables
  \listoffigures
  \mainmatter
}

% ---------------------------------------------------------------------------
% Required section macros (Proposal — Guidelines 2019, 8--10 pages)
% ---------------------------------------------------------------------------
\newcommand{\ProposalSections}{%
  \section{Problem Statement}%
  \section{Project Objectives}%
  \section{Significance of the Study}%
  \section{Literature Study/Review}%
  \section{Proposed Methodology}%
  \section{Proposed Performance Analysis Methodology and Validation Scheme}%
  \section{Proposed Deliverable/Output}%
  \section{Project Task and Time Schedule}%
  \section{Bibliography/References}%
}

% Mid-term extra sections (comment in source; use \section{} in document)
\newcommand{\MidtermExtraSections}{%
  \section{Tasks Done So Far}%
  \section{Results and Discussion}%
  \section{Tasks Remaining}%
}

% ---------------------------------------------------------------------------
% Bibliography heading alias
% ---------------------------------------------------------------------------
\newcommand{\ncitbibliography}{%
  \bibliographystyle{plain}
  \bibliography{references}
}

\makeatother
\endinput
