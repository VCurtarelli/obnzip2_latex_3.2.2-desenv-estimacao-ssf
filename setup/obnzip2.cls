%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Classe "setup/obnzip2.cls"
% NÃO MODIFICAR
%
% Autor: Vitor G. P. Curtarelli
%
% Data: 10/03/2026
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makeatletter
%%%%%
% Pacotes e classe
%%%%%

\ProvidesClass{setup/obnzip2}[2026/03/02 Template do OBNZip II]

\LoadClass{article}

\RequirePackage[utf8]{inputenc}
\RequirePackage{fontenc}
\RequirePackage[brazilian]{babel}  % Loads Portuguese settings (dates, titles)
\RequirePackage{amsmath, amsfonts, amsthm}
\RequirePackage{geometry}
\RequirePackage[colorlinks,linkcolor=black,citecolor=black]{hyperref}
\RequirePackage[nameinlink,brazilian,capitalize,]{cleveref}
\RequirePackage{xparse}
\RequirePackage[
backend=biber,
style=ieee,
doi=false,
isbn=false,
url=false,
citestyle=numeric-comp,
sorting=none,
sortcites=true]{biblatex}
\usepackage{xcolor}
\RequirePackage{enumitem}
\RequirePackage{calc}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{csquotes}
\RequirePackage{lipsum}
\RequirePackage{ragged2e}
\RequirePackage{expl3}
%%%%%
%
% Comandos-base
%
%%%%%

\geometry{margin=1in}
\NewDocumentCommand{\IfEmpty}{m m G{}}{\ifthenelse{\equal{#1}{}}{#2}{#3}}
\NewDocumentCommand{\IfEqual}{m m m G{}}{\ifthenelse{\equal{#1}{#2}}{#3}{#4}}
\NewDocumentCommand{\IfNotEmpty}{m m G{}}{\ifthenelse{\equal{#1}{}}{#3}{#2}}
\NewDocumentCommand{\itemcabecalho}{m m}{\IfNotEmpty{#2}{\item[\textit{#1}:] #2}}
\NewDocumentCommand{\@updatecommand}{m m G{}}{\edef#1{\IfNotEmpty{#1}{#1, }#2}\IfNotEmpty{#3}{\csname#3\endcsname{#2}}}

%%%%%
%
% Construção do cabeçalho e elementos dele
%
%%%%%

\def\@projeto{}
\def\@titulo{}
\def\@shorttitulo{}
\def\@subtitulo{}
\def\@autor{}
\def\@revisor{}
\def\@resumo{}
\def\@data{\today}
\def\@entregavel{}
\def\@entregavelcodigo{}
\def\@comentario{}
\newcounter{autores}
\newcounter{revisores}
\NewDocumentCommand{\addautor}{m}{\stepcounter{autores}}
\NewDocumentCommand{\contaautores}{>{\SplitList{,}}m}{\ProcessList{#1}{\addautor}}
\NewDocumentCommand{\addrevisor}{m}{\stepcounter{revisores}}
\NewDocumentCommand{\contarevisores}{>{\SplitList{,}}m}{\ProcessList{#1}{\addrevisor}}

\DeclareDocumentCommand{\projeto}{m}{\def\@projeto{#1}}
\DeclareDocumentCommand{\titulo}{o m}{\def\@titulo{#2}\IfValueTF{#1}{\def\@shorttitulo{#1}}{\def\@shorttitulo{#2}}}
\DeclareDocumentCommand{\subtitulo}{m}{\def\@subtitulo{#1}}
\DeclareDocumentCommand{\autor}{m}{\@updatecommand{\@autor}{#1}{contaautores}}
\DeclareDocumentCommand{\revisor}{m}{\@updatecommand{\@revisor}{#1}{contarevisores}}
\DeclareDocumentCommand{\resumo}{m}{\def\@resumo{#1}}
\DeclareDocumentCommand{\data}{m}{\def\@data{#1}}
\DeclareDocumentCommand{\entregavel}{m m}{\def\@entregavelcodigo{#1}\def\@entregavel{#2}}
\DeclareDocumentCommand{\comentario}{m}{\def\@comentario{#1}}

\DeclareDocumentCommand{\formarcabecalho}{}{
	\thispagestyle{firstpage}
	\IfEmpty{\@titulo}{\errmessage{Título vazio}}
	\IfEmpty{\@autor}{\errmessage{Autor vazio}}
	\IfEmpty{\@entregavel}{\errmessage{Atividade do projeto vazia}}
	\begin{center}
    \begin{minipage}{0.9\linewidth}
		\centering{
			% {\bfseries\small \@projeto} \\[0.5cm]
			{\bfseries\huge \@titulo}
			\IfEmpty{\@subtitulo}{\\[0.5cm]}{\\[0.25cm]{\bfseries\large \@subtitulo} \\[0.5cm]}
		}
		{
		\begin{itemize}[itemsep=0pt,
			leftmargin=\widthof{Entregável}+2ex]
			\small
			\itemcabecalho{Autor\ifthenelse{\value{autores}>1}{es}{}}{\@autor}
			\itemcabecalho{Revisor\ifthenelse{\value{revisores}>1}{es}{}}{\@revisor}
			\itemcabecalho{Data}{\@data}
			\itemcabecalho{Entregável}{\@entregavelcodigo~- \@entregavel}
			\itemcabecalho{Resumo}{\@resumo}
		\end{itemize}
		}
    \hrule
    \IfEmpty{\@comentario}{}{\vspace*{1em}\noindent\justifying\@comentario}
	\end{minipage}
    \end{center}
}

\input{setup/0.RelatorioInfo}

%%%%%
%
% Formatação do header no topo de cada página
%
%%%%%

\fancyhead{}%
\fancyhead[L]{%
	\includegraphics[height=0.5cm]{setup/logos/ufsc} \includegraphics[height=0.5cm]{setup/logos/obnzip} \includegraphics[height=0.5cm]{setup/logos/petrobras}
}
\setlength{\headheight}{18pt}%
\fancyhead[C]{\small{OBNZip II - \textit{\@entregavelcodigo~- \@shorttitulo}}}%
\fancyhead[R]{\small{\thepage}}%
\fancyfoot{}%

\fancypagestyle{firstpage}{%
	\fancyhead{}
	\fancyhead[L]{%
		\includegraphics[height=0.5cm]{setup/logos/ufsc} \includegraphics[height=0.5cm]{setup/logos/obnzip} \includegraphics[height=0.5cm]{setup/logos/petrobras}
	}%
	\setlength{\headheight}{18pt}%
	\fancyhead[C]{\small{\@projeto}}%
	\fancyhead[R]{\small{\thepage}}%
	\fancyfoot{}%
}

%%%%%
%
% Comandos finais da formatação do template
%
%%%%%

\projeto{OBNZip II - Inteligência Artificial Embarcada e Sensoriamento em OBNs}
\pagestyle{fancy}

%%%%%
%
% Modificações e configurações no BibLaTeX e no Cleveref
%
%%%%%

\DefineBibliographyStrings{brazilian}{
	presentedat = {apresentado em~}
}
\renewcommand*{\bibfont}{\small}
\addbibresource{setup/RelatorioReferencias.bib}


%%%%%
%
% Erros da não-edição dos dados do cabeçalho
%
%%%%%

\let\@lw\@ClassWarningNoLine
\NewDocumentCommand{\@AvisoTemplate}{m m G{#2}}{%
    \protected@edef\AvisoTemplateComando{\csname #3\endcsname}
    \IfEqual{\csname @#2\endcsname}{\csname @template#2\endcsname}{\@lw{obnzip2.cls}{Campo "#1" do cabeçalho não editado. Altere o argumento do comando \AvisoTemplateComando no arquivo "setup/0.RelatorioInfo.tex"}}
}

\def\@templatetitulo{Modelo em \LaTeX~para relatório de atividade}
\def\@templateshorttitulo{Template em \LaTeX}
\def\@templatesubtitulo{Para manter padrões no projeto}
\def\@templateautor{}
\def\@templaterevisor{}
\@updatecommand{\@templateautor}{Vitor Curtarelli, Ciclano Silva}
\@updatecommand{\@templaterevisor}{Beltrano Souza}
\def\@templateentregavelcodigo{0.1.1}
\def\@templateentregavel{Padronização dos relatórios do projeto}
\def\@templateresumo{Esse documento é um modelo a ser usado nos relatórios de atividades dentro do projeto OBNZip II, bem como para outros documentos em geral.}    
\def\@templatecomentario{Atente-se a todos os comandos presentes nesse template.}


\@AvisoTemplate{Título}{titulo}
\@AvisoTemplate{Título-curto}{shorttitulo}{titulo}
\@AvisoTemplate{Subtítulo}{subtitulo}
\@AvisoTemplate{Autor(es)}{autor}
\@AvisoTemplate{Revisor(es)}{revisor}
\@AvisoTemplate{Código do entregável}{entregavelcodigo}{entregavel}
\@AvisoTemplate{Descrição do entregável}{entregavel}
\@AvisoTemplate{Resumo}{resumo}
\@AvisoTemplate{Comentário}{comentario}

%%%%%
%
%%%%%
\makeatother