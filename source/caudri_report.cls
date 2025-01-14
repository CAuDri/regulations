% CAuDri Report Document Class 
% Based on KOMA-Script scrreprt class
% Version: 2024/12/03
%
% Usage:
% \documentclass{caudri_report}
%
% \Title{MyTitle}
% \Subtitle{MySubtitle}
% \Author{Me}
% \Date{\today}

% \begin{document}
% \Titlepage        % Create title page
% 
% \useportrait      % For upright page
% \uselandscape     % For horizontal page
% \end{document}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{caudri_report}[2024/12/03 v1.0 CAuDri Document Class Based on scrreprt]
\LoadClass[11pt, parskip=half]{scrreprt}

% Load additional packages
\RequirePackage[T1]{fontenc}                    % T1 font encoding
\RequirePackage{lmodern}                        % Latin Modern font (somehow more compatible than Computer Modern)
\RequirePackage[headsepline]{scrlayer-scrpage}  % Header and footer management
\RequirePackage{graphicx}                       % For including images
\RequirePackage{hyperref}                       % For hyperlinks and text fields
\RequirePackage{tikz}                           % For custom text fields
\RequirePackage{tabularx}                       % For tables with fixed width
\RequirePackage{multicol}                       % For multiple column pages
% \RequirePackage[german]{datetime2}              % For german date formatting
\RequirePackage{float}                          % The most important package ever

% Default text in header
\newcommand{\HeaderText}{CAuDri-Challenge 2025}

\graphicspath{{./graphics/}, {../graphics/}, {./}, {../}} 

% Use sans-serif as default font family
\renewcommand{\familydefault}{\sfdefault}

% Configure default page layout
\KOMAoptions{
  headheight=3cm,
  DIV=12 % Page division, controls general page layout and margins
  % parskip=false % No spacing between paragraphs
}

% Add space to the top of the header
% Needs to be defined manually, setting it via KOMA Options won't have any effect
\setlength{\headheight}{3.3cm}

% Load scrlayer-scrpage for header/footer management
\clearpairofpagestyles % Clear default header and footer settings

% Define headers and footers 
\setkomafont{pagehead}{\normalfont}
\ihead{\large\HeaderText\\\large\Subtitle}
\ohead{\includegraphics[width=3.5cm]{caudri_logo.png}}

% Enable header on chapter pages and redefine chapter spacing
\renewcommand*\chapterpagestyle{scrheadings}
\RedeclareSectionCommand[
  beforeskip=.25\baselineskip,
  afterskip=\baselineskip,
]{chapter}

% Define hyperref link colors
\hypersetup{colorlinks  = true,
            linkcolor   = black,
            urlcolor    = blue,
            citecolor   = black,
            anchorcolor = black}

% Slightly scale the height of table rows
\renewcommand{\arraystretch}{1.2}

% Custom commands for layout switching
\newcommand*{\useportrait}{%
  \clearpage
  \KOMAoptions{paper=portrait,DIV=12}
  \setlength{\headheight}{3.3cm}
}

\newcommand*{\uselandscape}{%
  \clearpage
  \KOMAoptions{paper=landscape,DIV=13}
  \setlength{\headheight}{4.3cm}
}

% Custom commands for setting title, subtitle, author, and date
\newcommand{\Title}[1]{%
  \def\@title{#1}%
  \gdef\Title{#1} % Global definition of \Title for use in headers/footers
}
\newcommand{\Subtitle}[1]{%
  \def\@subtitle{#1}%
  \gdef\Subtitle{#1} % Global definition of \Subtitle for use in headers/footers
}
\newcommand{\Author}[1]{\def\@author{#1}}
\newcommand{\Date}[1]{\def\@date{#1}}

% Create the title page using "\Titlepage"
\makeatletter
\newcommand{\Titlepage}{
  \begin{center}
    {\LARGE\bfseries\@title\\}
    \vspace{0.5\baselineskip}
    % {\large\@subtitle}\\
    \@date
    \bigskip
  \end{center}
}
\makeatother

% Custom commands for fillable text fields
\renewcommand{\LayoutTextField}[2]{% label, field
  \begin{tikzpicture}[baseline, every node/.style={inner sep=0,outer sep=0}]
    % Align the text field with the baseline of the surrounding text
    \node[anchor=base] (TextFieldNode) at (0cm,-2pt) {#2};
    % Position the label below the text field, without affecting vertical alignment
    \node[anchor=north west,font=\footnotesize] at ([yshift=-0.3ex]TextFieldNode.south west) {#1};
  \end{tikzpicture}%
}

\newcounter{fieldcounter}
\newcommand{\TextFieldInline}[2]{\TextField[name=\thefieldcounter,width=#2,borderstyle=U,bordercolor={0 0 0},backgroundcolor={1 1 1}]{#1}\stepcounter{fieldcounter}}


% Custom commands for checkboxes 
\renewcommand{\LayoutCheckField}[2]{\parbox[c][4mm]{4mm}{\centering #2}}
\renewcommand\DefaultHeightofCheckBox{3mm}
\renewcommand\DefaultWidthofCheckBox{3mm}

\newcommand{\CheckBoxInline}{\CheckBox[bordercolor={0 0 0}]{0cm}}

% End of class definition
\endinput
