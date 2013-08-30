\ProvidesClass{biopaper}[2013/08/27 SMCM Biology paper; because I've no idea]

% Any options I don't specificaly define, just pass along to the
% `apa6e` class (APA Sixth Edition).
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{apa6e}}
\ProcessOptions\relax

% Load our base class.  (All of the hard work: done!)
\LoadClass{apa6e}

\RequirePackage{xparse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Bibliography Management %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We speak American!  Seriously, this is needed by biblatex.
\PassOptionsToPackage{american}{babel}
\RequirePackage{babel}

% And our papers for Biology are in the APA style (I believe)
\PassOptionsToPackage{style=apa,autocite=inline}{biblatex}
\RequirePackage{biblatex}

% And we need to make sure we title our shtuff appropriately
% (e.g. Works Cited -> References)
\DeclareLanguageMapping{american}{american-apa}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% They really just look better.
\RequirePackage{booktabs}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Chemical Formulae %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\PassOptionsToPackage{version=3}{mhchem}
\RequirePackage{mhchem}

\NewDocumentCommand \reaction { s o m } {
  \IfBooleanTF #1 {
    \begin{equation*}
      \ce{#3}
    \end{equation*}
 }{ \begin{equation}
      \IfValueTF{#2}{\label{#2}}{}
      \ce{#3}
    \end{equation}
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Typographic Enhancements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{microtype}

\RequirePackage{authblk}

% We want hyper-references (and \autoref!!), so bring in the hyperref
% package.
\PassOptionsToPackage{hidelinks}{hyperref}
\RequirePackage{hyperref}
