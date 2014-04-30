\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\RequirePackage{smcm-common}
\ProvidesExplClass
{smcm-cosc-smp}
{2014/03/01}
{1.0}
{A class for St. Mary's Projects in Computer Science}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Key-Value Interface %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AfterPackage{listings}{
  \RequirePackage{smcm-cosc-listings}
}

\PassOptionsToClass{letterpaper,12pt}{article}


\keys_define:nn { smcm-cosc-smp }
  {
    minp .int_set:N = \g_smcm_cosc_smp_page_min_int,
    minp .default:n = 0,
    maxp .int_set:N = \g_smcm_cosc_smp_page_max_int,
    maxp .default:n = 9999,
    default .code:n = {
      \msg_info:nnnn { smcm-cosc-smp }
                     { unknown-option }
                     { \l_keys_key_tl }
                     { #1 }
       \PassOptionsToClass{\l_keys_key_tl}{article}
     },
  }

\LoadClass{article}
%\PassOptionsToPackage{log-declarations=false}{xparse}
\RequirePackage[margin=1in]{geometry}
\RequirePackage[format=hang]{caption}

\ProcessKeysOptions{ smcm-cosc-smp }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Messages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\msg_new:nnnn { smcm-cosc-smp } { page-length } {
  Your ~ paper ~ doesn't ~ meet ~ the ~ given ~ page ~ limits.
} {
  This ~ paper ~ was ~ set ~ with ~ the ~ following ~ bounds:
   ~ ~ Minimum: ~ #1
   ~ ~ Maximum: ~ #2
  Your ~ paper ~ has ~ #3 ~ pages.
}

\msg_new:nnnn { smcm-cosc-smp } { unknown-option } {
  I ~ don't ~ know ~ the ~ option ~ `#1=#2`.
} {
  I'm ~ passing ~ it ~ along ~ to ~ the ~ document ~ class.
}

\msg_new:nnnn { smcm-cosc-smp } { invalid-bounds } {
  Invalid ~ page ~ bounds.
} {
  The ~ minimum ~ cannot ~ be ~ greater ~ than ~ the ~ maximum.
   ~ ~ Minimum: ~ #1
   ~ ~ Maximum: ~ #2
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Private Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ensure that min <= max
\cs_new:Nn \smcm_cosc_smp_validate_bounds: {
  \int_compare:nNnT { \g_smcm_cosc_smp_page_min_int } > { \g_smcm_cosc_smp_page_max_int }
    {
      \msg_error:nnnn { smcm-cosc-smp } { invalid-bounds }
        { \g_smcm_cosc_smp_page_min_int }
        { \g_smcm_cosc_smp_page_max_int }
    }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Redefine Structural Commands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% todo make pdf string @title: @subtitle
\RenewDocumentCommand \title { m o } {
  \def\@title{#1}
  \IfValueT { #2 } { \def\@subtitle{#2} }
}
\RenewDocumentCommand \author { m o } {
  \def\@author{#1}
  \IfValueT { #2 } { \def\@advisor{#2} }
}

\RenewDocumentCommand \@maketitle { } {
  \newpage
  \null
  \vskip 2em
  \begin{center}
    \let \footnote \thanks
    {
      \LARGE \@title
      \cs_if_exist:NT \@subtitle {
        \\[1ex] \large \@subtitle
      }
      \par
    }
    \vskip 1.5em
    {
      \large \lineskip .5em
      \begin{tabular}[t]{c}
        \@author
      \cs_if_exist:NT \@advisor {
        \thanks{
          Advised ~ by ~ \@advisor
        }
      }
      \end{tabular}
      \par
    }
    \vskip 1em
    {
      \large \@date
    }
  \end{center}
  \par
  \vskip 1.5em
}

% Check page bounds for min/max
% todo have macros \startpagecount and \stoppagecount
\AtEndDocument{
  \bool_if:nT
  {
    % If we are under the minimum
    \int_compare_p:nNn { \thepage } < { \g_smcm_cosc_smp_page_min_int }
    ||                          % or over the maximum
    \int_compare_p:nNn { \g_smcm_cosc_smp_page_max_int } < { \thepage }
  } {                           % issue a warning
    \msg_warning:nnnnn { smcm-cosc-smp } { page-length }
                       { \g_smcm_cosc_smp_page_min_int }
                       { \g_smcm_cosc_smp_page_max_int }
                       { \thepage }
  }
}

\NewDocumentCommand \SMPSetup { m } {
  \keys_set:nn { smcm-cosc-smp } { #1 }
  \smcm_cosc_smp_validate_bounds:
}

\box_new:N \smcm_cosc_warning_box
\NewDocumentCommand \SetWarningEnvironmentText { O{\bfseries} m O{\quad}} {
  \hbox_set:Nn \smcm_cosc_warning_box {
    {
      #1
      #2
      #3
    }
  }
}

\SetWarningEnvironmentText{ Warning: }
\NewDocumentEnvironment { warning } { O{1} } {
  \par
  \dim_set:Nn \hangindent {
    \box_wd:N \smcm_cosc_warning_box
  }

  \vspace{1ex plus .2ex minus .1ex}
  \noindent
  \hspace{\dimexpr  -1 in + \parindent\relax}

  \makebox[\dimexpr +1 in - \parindent\relax][c]{
    \prg_replicate:nn {#1} {\dbend\,}\unskip}

  \box_use:N \smcm_cosc_warning_box
  \ignorespaces
}{
  \par
  \vspace{1ex plus .2ex minus .1ex}
}


\NewDocumentEnvironment { draftvspace } { m } {
  \center
  \rule{1pt}{\dimexpr #1 / 2 \relax}
  \par
}{
  \par
  \rule{1pt}{\dimexpr #1 / 2 \relax}
  \endcenter
}

\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{2}

\setlength\parskip{1ex}
\setlength\parindent{0em}
\AfterPackage{biblatex}{
  \setlength\bibitemsep{2ex}
}
