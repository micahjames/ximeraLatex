% A LaTeX2e document class for preparing handouts and online material
% via Ximera.

%% ximera.cls
%% Copyright (c) 2013 Bart Snapp and Jim Fowler
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2013/12/01 or later.
%
% This work has the LPPL maintenance status "author-maintained".
% 
% This work consists of the files ximera.cls


%%% Bart Snapp
%%% Department of Mathematics
%%% The Ohio State University


\def\fileversion{.55}
\def\filedate{2013/09/16}



% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
% If there's some feature that you'd like that this file doesn't
% provide, tell Bart Snapp or Jim Fowler about it.  
%
% Thanks to: 
%
% Philip Hirschhorn as this document class is based on his
% ``exam.cls.'' The original work can be found at:
% http://www-math.mit.edu/~psh/
% --------------------------------------------------------------------
% --------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{ximera}[\filedate\space Version \fileversion\space by
  Bart Snapp]

\newif\ifhandout
\handoutfalse
\DeclareOption{handout}{\handouttrue}

\newif\ifnewpage
\newpagefalse
\DeclareOption{newpage}{\newpagetrue}

\newif\ifnumbers
\numbersfalse
\DeclareOption{numbers}{\numberstrue}

\newif\ifhints
\hintstrue
\DeclareOption{nohints}{\hintsfalse}

\newif\ifshuffle
\shufflefalse

\newif\ifspace 
\spacefalse
\DeclareOption{space}{\spacetrue}
%% This basically works for exercises, though page breaks are weird. 





\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}



\RequirePackage{titlesec} 
\RequirePackage{titletoc} 
\RequirePackage{titling}  
\RequirePackage{url}
\RequirePackage{xcolor}
\RequirePackage{pgfplots}
\RequirePackage{fancyvrb}
\RequirePackage{environ}
\RequirePackage{xcolor}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{xifthen}% http://ctan.org/pkg/xifthen
\RequirePackage{multido}% http://ctan.org/pkg/multido
\RequirePackage{listings}
\RequirePackage{comment}

%\usepackage[hypertexnames=false]{hyperref}



\newcommand{\answer}[1][]{}
\newcommand{\prerequisites}[1]{}
\newcommand{\outcomes}[1]{}
\newcommand{\video}[1]{\footnote{Video link: \url{#1}}}
\newcommand{\youtube}[1]{\footnote{YouTube link: \url{#1}}}
\newcommand{\link}[1]{\footnote{Link: \url{#1}}}

\renewcommand{\labelsep}{3ex} %% Space after thm/problem label

\newboolean{correct}
\setboolean{correct}{true}
\newcommand{\choice}[2][]{\item #2\ifthenelse{\boolean{#1}}{\ifhandout \else \quad\checkmark\fi}{}}


\everymath{\displaystyle} %makes everymath display style, could be optional


%% image environment
\NewEnviron{image}[1][]{
\[
\BODY
\]}


%% interactive envrironment
\NewEnviron{interactive}[1][]{\BODY}


%% these may be changed in the future to work more like interactive.
%% expression-answer envrironment
\NewEnviron{expression-answer}[1][]{}

%% matrix-answer envrironment
\NewEnviron{matrix-answer}[1][]{}

%% free-response answer envrironment
\NewEnviron{free-response}[1][]{\BODY}



% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
%
%                    ******************************************
%                    ** ACTIVITY-TITLE AND SHORT-DESCRIPTION **
%                    ******************************************
%
%
%


%% \newcommand{\activitytitlebreak}{\clearpage}

\makeatletter
\let\abstract\relax
\let\endabstract\relax
\NewEnviron{abstract}{\protected@xdef\theabstract{\BODY}}
\makeatother

\newcounter{titlenumber}
\renewcommand{\thetitlenumber}{\arabic{titlenumber}}
\setcounter{titlenumber}{1}

\makeatletter
\renewcommand\@maketitle{%
  \addcontentsline{toc}{subsection}{\@title} %% puts titles in the toc
  {\flushleft\LARGE\bfseries {\ifnumbers\thetitlenumber\fi}{\ifnumbers\hspace{1em}\else\hspace{0em}\fi}\@title \par }
  \vskip .6em\noindent\textit\theabstract\setcounter{problem}{0}\addtocounter{titlenumber}{1}\par\vspace{2em}}
\makeatother


% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
%
%                    ***************************
%                    ** PROBLEM ENVIRONMENTS **
%                    ***************************
%
%






\newcounter{problem} %% for the main problem
\newcounter{problemType} %% for variations within shuffle

% ---------------------------------------------------------------------
% Problem environment decorations

% The decoration for these envrionments were inspired by
% http://tex.stackexchange.com/questions/11098/nice-formatting-for-theorems?lq=1

%\makeatletter%
\newcommand{\hang}{% top theorem decoration
  \begingroup%
  \setlength{\unitlength}{.005\linewidth}% \linewidth/200
    \begin{picture}(0,0)(1.5,0)%
      \linethickness{1pt} \color{black!50}%
      \put(-3,2){\line(1,0){206}}% Top line
      \multido{\iA=2+-1,\iB=50+-10}{5}{% Top hangs
        \color{black!\iB}%
        \put(-3,\iA){\line(0,-1){1}}% Top left hang
        %\put(203,\iA){\line(0,-1){1}}% Top right hang
      }%
    \end{picture}%
  \endgroup%
}%
\newcommand{\hung}{% bottom theorem decoration
  \nobreak
  \begingroup%
    \setlength{\unitlength}{.005\linewidth}% \linewidth/200
    \begin{picture}(0,0)(1.5,0)%
      \linethickness{1pt} \color{black!50}%
      \put(60,0){\line(1,0){143}}% Bottom line
      \multido{\iA=0+1,\iB=50+-10}{5}{% Bottom hangs
        \color{black!\iB}%
        %\put(-3,\iA){\line(0,1){1}}% Bottom left hang
        \put(203,\iA){\line(0,1){1}}% Bottom right hang
        \put(\iB,0){\line(60,0){10}}% Left fade out
      }%
    \end{picture}%
  \endgroup%
}%


% ---------------------------------------------------------------------
% Problem environments: Exercise, Question, Exploration



%%% shuffle environment
\newif\iffirstproblem% Condition for first problem
\firstproblemtrue

\newenvironment{shuffle}[1][]
{\shuffletrue\setcounter{problemType}{0}}
{\refstepcounter{problem}
\shufflefalse
\global\firstproblemtrue}


\newenvironment{exercise}[1][2in]
{\iffirstproblem
\def\spaceatend{#1}\refstepcounter{problem}\refstepcounter{problemType}
\begin{trivlist}\item[\hskip\labelsep\sffamily\bfseries 
Exercise \ifhandout\theproblem\else\ifshuffle\theproblem.\theproblemType\else\theproblem\fi\fi]
\slshape
\else\setbox0\vbox\bgroup\fi} %% removes exercise if in shuffle and not first problem
{\iffirstproblem
\ifhandout\ifspace\vspace{\spaceatend}\fi\fi %% space at end
\par\addvspace{.5ex}\nobreak\noindent\hung %% line at the bottom
\ifshuffle\addtocounter{problem}{-1}\fi %% the problem does not increase within shuffle
\ifhandout\ifshuffle\global\firstproblemfalse\fi\fi %% removes other problems from shuffle in handout
\ifhandout\ifnewpage\newpage\fi\fi %% adds newpage
\end{trivlist}
\else\egroup\fi}



\newenvironment{question}[1][2in]
{\iffirstproblem
\def\spaceatend{#1}\refstepcounter{problem}\refstepcounter{problemType}
\begin{trivlist}\item[\hskip\labelsep\sffamily\bfseries 
Question \ifhandout\theproblem\else\ifshuffle\theproblem.\theproblemType\else\theproblem\fi\fi]
\slshape
\else\setbox0\vbox\bgroup\fi} %% removes exercise if in shuffle and not first problem
{\iffirstproblem
\ifhandout\ifspace\vspace{\spaceatend}\fi\fi %% space at end
\par\addvspace{.5ex}\nobreak\noindent\hung %% line at the bottom
\ifshuffle\addtocounter{problem}{-1}\fi %% the problem does not increase within shuffle
\ifhandout\ifshuffle\global\firstproblemfalse\fi\fi %% removes other problems from shuffle in handout
\ifhandout\ifnewpage\newpage\fi\fi %% adds newpage
\end{trivlist}
\else\egroup\fi}



\newenvironment{exploration}[1][2in]
{\iffirstproblem
\def\spaceatend{#1}\refstepcounter{problem}\refstepcounter{problemType}
\begin{trivlist}\item[\hskip\labelsep\sffamily\bfseries 
Exploration \ifhandout\theproblem\else\ifshuffle\theproblem.\theproblemType\else\theproblem\fi\fi]
\slshape
\else\setbox0\vbox\bgroup\fi} %% removes exercise if in shuffle and not first problem
{\iffirstproblem
\ifhandout\ifspace\vspace{\spaceatend}\fi\fi %% space at end
\par\addvspace{.5ex}\nobreak\noindent\hung %% line at the bottom
\ifshuffle\addtocounter{problem}{-1}\fi %% the problem does not increase within shuffle
\ifhandout\ifshuffle\global\firstproblemfalse\fi\fi %% removes other problems from shuffle in handout
\ifhandout\ifnewpage\newpage\fi\fi %% adds newpage
\end{trivlist}
\else\egroup\fi}




%% Solution environment
\newenvironment{solution}{
\ifhandout\setbox0\vbox\bgroup\else
\begin{trivlist}\item[\hskip \labelsep\small\itshape\bfseries Solution\hspace{2ex}]
\par\noindent\upshape\small
\fi}
{\ifhandout\egroup\else
\end{trivlist}
\fi}


\newenvironment{hint}{
\ifhints
\begin{trivlist}\item[\hskip \labelsep\small\slshape\bfseries\color{gray} Hint:\hspace{2ex}]
\small\slshape\color{gray}
\else\setbox0\vbox\bgroup
\fi}
{\ifhints
\end{trivlist}
\else\egroup\fi}



           


%% multiple choice environment
\renewcommand{\theenumi}{$(\mathrm{\alph{enumi}})$}
\renewcommand{\labelenumi}{\theenumi}
\newenvironment{multiple-choice}[1][]
{\begin{enumerate}}
{\end{enumerate}}





%% python answer environment
%% You cannot use Envrion with the fancyvrb/listings package if you want nested environments

\DefineVerbatimEnvironment{python}{Verbatim}{numbers=left,frame=lines,label=Python,labelposition=topline}
%% \lstnewenvironment{python}
%% {\lstset{language=python,numbers=left}}
%% {}



% ---------------------------------------------------------------------
% ---------------------------------------------------------------------
%
%                    *******************************
%                    ** THEOREM-LIKE ENVIRONMENTS **
%                    *******************************
%
%
%


\newtheoremstyle{SlantTheorem}
	{\topsep}{\topsep}              %%% space between body and thm
	{\slshape}                      %%% Thm body font
	{}                              %%% Indent amount (empty = no indent)
	{\bfseries}            %%% Thm head font
	{}                              %%% Punctuation after thm head
	{\labelsep}                           %%% Space after thm head
	{\thmname{#1}\thmnumber{ #2}\thmnote{ \bfseries(#3)}}%%% Thm head spec
\theoremstyle{SlantTheorem}
\newtheorem{theorem}{Theorem}
\newtheorem{acknowledgement}[theorem]{Acknowledgement}
\newtheorem{algorithm}[theorem]{Algorithm}
\newtheorem{axiom}[theorem]{Axiom}
\newtheorem{claim}[theorem]{Claim}
\newtheorem{conclusion}[theorem]{Conclusion}
\newtheorem{condition}[theorem]{Condition}
\newtheorem{conjecture}[theorem]{Conjecture}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{criterion}[theorem]{Criterion}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{notation}[theorem]{Notation}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{remark}[theorem]{Remark}
\newtheorem{summary}[theorem]{Summary}
\newtheorem{paradox}[theorem]{Paradox}
\newtheorem{warning}[theorem]{Warning}
\newtheorem{observation}[theorem]{Observation}

\renewenvironment{proof}[1][\proofname]{\begin{trivlist}\item[\hskip \labelsep \itshape \bfseries #1{}\hspace{2ex}]}
{\qed\end{trivlist}}

\renewcommand{\qedsymbol}{$\blacksquare$}





\endinput
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
