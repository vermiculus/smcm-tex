\ProvidesClass{biopaper}[2013/08/27 SMCM Biology paper; because I've no idea]

% Any options I don't specificaly define, just pass along to the
% `article` class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{apa6e}}
\ProcessOptions\relax

% Load our base class.
\LoadClass{apa6e}


% We speak American, dammit!
\usepackage[american]{babel}

% And our papers for Biology are in the APA style (I believe)
\usepackage[style=apa,autocite=inline]{biblatex}
% And we need to make sure we title our shtuff appropriately (e.g. Works Cited -> References)
\DeclareLanguageMapping{american}{american-apa}

\usepackage[hidelinks]{hyperref}