%% ncitproject.cls
%% Nepal College of Information Technology — Academic Project Guidelines 2019
%% Report formatting for Project I / II (Minor) / III (Major): Proposal, Mid-term, Final
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ncitproject}[2019/05/24 NCIT Academic Project Report Class]

\LoadClass[11pt,a4paper,oneside]{article}

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
  left=1.5in,
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
% Headers, footers — project title; [current/total] at bottom centre
% ---------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}

\newcommand{\ncit@projecttitle}{}
\newcommand{\ProjectTitle}[1]{\renewcommand{\ncit@projecttitle}{#1}}

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0.4pt}
\fancyhead[C]{\small\normalfont\ncit@projecttitle}
\fancyfoot[C]{\small [\thepage/\pageref{LastPage}]}
\fancypagestyle{plain}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[C]{\small [\thepage/\pageref{LastPage}]}
}

\AtEndDocument{\label{LastPage}}

% ---------------------------------------------------------------------------
% Section numbering (legal / decimal style) and new page per section
% ---------------------------------------------------------------------------
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}

\pretocmd{\section}{\clearpage}{}{}

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

% ---------------------------------------------------------------------------
% UML 2.0 figure placeholder — replace with \umlfigure when PDF is ready
% ---------------------------------------------------------------------------
\newcommand{\umlplaceholder}[4]{%
  \begin{figure}[ht]
    \centering
    \fbox{%
      \parbox[c][0.36\textwidth][c]{0.9\textwidth}{%
        \centering\small
        \textbf{UML 2.0 --- #4}\\[0.8em]
        \textit{Placeholder --- insert diagram before defense}\\[0.6em]
        \texttt{figures/uml/#3}%
      }%
    }
    \caption{#2}
    \label{fig:#1}
  \end{figure}%
}

% \umlfigure{label}{basename}{caption} — auto-includes PDF/PNG/EPS or shows box
\newcommand{\umlfigure}[3]{%
  \begin{figure}[ht]
    \centering
    \IfFileExists{figures/uml/#2.pdf}{%
      \includegraphics[width=\textwidth]{figures/uml/#2}%
    }{%
      \IfFileExists{figures/uml/#2.png}{%
        \includegraphics[width=\textwidth]{figures/uml/#2}%
      }{%
        \IfFileExists{figures/uml/#2.eps}{%
          \includegraphics[width=\textwidth]{figures/uml/#2}%
        }{%
          \fbox{%
            \parbox[c][0.36\textwidth][c]{0.9\textwidth}{%
              \centering\small
              \textit{Missing file: \texttt{figures/uml/#2.(pdf|png|eps)}}%
            }%
          }%
        }%
      }%
    }%
    \caption{#3}%
    \label{fig:#1}%
  \end{figure}%
}

% ---------------------------------------------------------------------------
% Figures, tables, equations (centred; captions; equation numbers right)
% ---------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{amsmath,amssymb}
\RequirePackage{caption}
\captionsetup{
  font=small,
  labelfont=bf,
  justification=centering,
  singlelinecheck=false
}
\RequirePackage{booktabs}
\RequirePackage{tabularx}

% ---------------------------------------------------------------------------
% Hyperlinks (black for print)
% ---------------------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  urlcolor=blue,
  citecolor=black,
  pdfauthor={NCIT Project Report}
}

% ---------------------------------------------------------------------------
% Front matter / main matter page numbering
% Roman: Acknowledgement through List of Tables
% Arabic: Introduction onward
% ---------------------------------------------------------------------------
\newcommand{\frontmatter}{%
  \clearpage
  \pagenumbering{roman}
  \setcounter{page}{1}%
}
\newcommand{\mainmatter}{%
  \clearpage
  \pagenumbering{arabic}
  \setcounter{page}{1}%
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
  Student Name & Roll No. XXXXXX \\
}

\newcommand{\SetStudents}[1]{\renewcommand{\ncit@students}{#1}}
\newcommand{\AddStudent}[2]{%
  \g@addto@macro\ncit@students{#1 & #2 \\}%
}

\newcommand{\ncit@collegebanner}{%
  {\ncit@collegefont
    NEPAL COLLEGE OF\\INFORMATION TECHNOLOGY}%
}

\newcommand{\maketitlepage}{%
  \ncit@setstage
  \begin{titlepage}
    \thispagestyle{empty}
    \centering
    \vspace*{1.5cm}
    {\large
      A \textbf{\ncit@projectkind} Project \textbf{\ncit@reportstage} Report on\\[1.2em]
      {\bfseries\large \ncit@title}\\[2em]
      Submitted in Partial Fulfillment of the Requirements for\\[0.6em]
      the Degree of \textbf{\ncit@degree}\\[0.4em]
      under Pokhara University\\[2em]
      Submitted by:\\[0.8em]
    }
    \begin{tabular}{@{}l@{\quad}l@{}}
      \ncit@students
    \end{tabular}\\[2em]
    {\large
      Under the supervision of\\[0.6em]
      \textbf{\ncit@supervisor}\\[0.3em]
      \ncit@supervisordesignation\\[2em]
      Date: \ncit@date\\[3em]
      Department of \textbf{\ncit@department}\\[4em]
    }
    \ncit@collegebanner\\[0.6em]
    {\large Balkumari, Lalitpur, Nepal.}
    \vfill
  \end{titlepage}
  \ProjectTitle{\ncit@title}
}

% ---------------------------------------------------------------------------
% Abstract with keywords (max 250 words — guideline)
% ---------------------------------------------------------------------------
\newcommand{\ncit@keywords}{}
\newcommand{\Keywords}[1]{\renewcommand{\ncit@keywords}{#1}}

\newenvironment{ncitabstract}{%
  \clearpage
  \section*{Abstract}
  \addcontentsline{toc}{section}{Abstract}
}{%
  \par\vspace{1em}\noindent\textbf{Keywords:} \ncit@keywords
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
