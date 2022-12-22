<?php

require_once "../../lib/conexao.php";
require_once "../../lib/upload.php";
require_once "../../lib/caracteres_sem_acento.php";

// caso haja problemas de preenchimento do latex
$nome = ((!isset($_POST['nome']) || (strlen($_POST['nome']) == 0)) ? "aula.tex" : trim($_POST['nome']).".tex");
$com_sem_section = ((!isset($_POST['com_sem_section']) || (strlen($_POST['com_sem_section']) == 0)) ? false : true);

// fazendo upload das imagens
upload($_FILES, DIR."bin/latex/figuras/");

$zip = new ZipArchive();
$filename = "./aula.zip";
if ($zip->open($filename, ZipArchive::CREATE)!==true) {
    exit("cannot open <$filename>\n");
}
$x = scandir(DIR."/bin/latex/figuras/");
foreach ($x as $key => $value) {
    if ('.' !== $value && '..' !== $value) {
        $zip->addFile("figuras/".$value);
    }
}

$latex = "\\documentclass[table, usenames, svgnames, dvipsnames]{beamer}
\\usepackage[portuguese]{babel}
\\usepackage[latin1]{inputenc}
\\usepackage[absolute,overlay]{textpos}
\\usepackage{array}
\\usepackage{xcolor}
\\usetheme{Luebeck}
\\usecolortheme[named=SeaGreen]{structure}
\\usecolortheme{spruce}
\\definecolor{corsubsection}{RGB}{42, 127, 79}
\\setbeamerfont{title}{size=\\large}
\\setbeamerfont{frametitle}{size=\\large}
\\setbeamercolor{section in head/foot}{fg=white, bg=SeaGreen}
\\setbeamercolor{subsection in head/foot}{fg=white, bg=corsubsection}
\\setbeamercolor{block title alerted}{fg=white,bg=red}
\\setbeamercolor{block body alerted}{fg=black,bg=pink}
\\beamertemplatenavigationsymbolsempty
\\setbeamertemplate{footline}[frame number]
\\AtBeginSection[] 
{
  \\begin{frame}<handout:0>
    \\frametitle{\\textbf{Agenda}}
    \\footnotesize{ \\tableofcontents[currentsection,hideothersubsections] }
  \\end{frame}
}

\\DeclareGraphicsExtensions{.pdf,.jpg,.png} % compilamos apenas com pdflatex
\\graphicspath{{./figuras/}} 
\\title{\\textbf{".str_replace(".tex", " ", trim($nome))."}}

\\subtitle{}


\\author[Prof. teste]{\scriptsize
  ".(isset($_POST['professor']) && !empty($_POST['professor']) ? "Prof.".$_POST['professor'] : "")."\\\\ \n
}
\\institute{\\\\[1.0mm] 
  ".(isset($_POST['instituto']) && !empty($_POST['instituto']) ? $_POST['instituto'] : "")."\\\\ \n
  }
\\date{}

\\begin{document}  
    
{%\\usebackgroundtemplate{}} 
  \\begin{frame}[plain]
    %\\begin{figure}
    \\centering
    % \\includegraphics[width=0.8\\linewidth]{figuras/principal_superior_dc}
    %   \\caption{}
    % \\label{fig:principal_superior_dc}
    % \\end{figure}  
    %   \\vspace{6px}    
    \\titlepage  
%   \\addtocounter{framenumber}{-1}
  \\end{frame}
}
\\begin{frame}
\\frametitle{\\textbf{Agenda}}
  \\footnotesize{ \\tableofcontents }
\\end{frame}";

$types = array( 'png', 'jpg', 'jpeg');

if ($handle = opendir("figuras/")) {
    while ($entry = readdir($handle)) {
        $ext = strtolower(pathinfo($entry, PATHINFO_EXTENSION));
        if (in_array($ext, $types)) {
            $x = array(".png", ".jpg", ".jpeg", "_");
            $y = array("","",""," ");
            if ($com_sem_section) {
                $latex .= "\n\n". " \\section{".str_replace($x, $y, trim($entry))."}  \n\n";
            }
            $latex .= "\n\n"
            . " \\begin{frame} \n"
            . "\\frametitle{".str_replace($x, $y, $entry). "}\n"
            . "\\begin{figure}\n"
            . "\\centering\n"
            . "\\includegraphics[width=0.5\\linewidth]{figuras/".trim($entry). "}\n"
            . "\\caption{". str_replace($x, $y, trim($entry)). "}\n"
            . "\\label{fig:". strtr(strtolower(str_replace(" ","_",str_replace($x, $y, $entry))), $caracteres_sem_acento). "}\n"
            . "\\end{figure}\n"
            . "\\end{frame} \n\n";
        }
    }
    closedir($handle);
    $latex .= ""
    . "{%\\usebackgroundtemplate{}}\n"
    . "\\begin{frame}[plain]\n"
    . "\\titlepage \n"
    . "	\\end{frame}\n"
    . "\\end{document}";
}

$latexFile =fopen($nome, "w+");
fwrite($latexFile, utf8_decode($latex));
fclose($latexFile);
$zip->addFile($nome);
// echo "numfiles: " . $zip->numFiles . "\n";
// echo "status:" . $zip->status . "\n";
$zip->close();

// deletando...
unlink($nome);
$x = scandir(DIR."/bin/latex/figuras/");
foreach ($x as $key => $value) {
    if ('.' !== $value && '..' !== $value) {
        unlink("figuras/".$value);
    }
}

// forcando o download
header('Content-type: application/zip');
header('Content-Disposition: attachment; filename="'.basename($filename).'"');
header("Content-length: " . filesize($filename));
header("Pragma: no-cache");
header("Expires: 0");
ob_clean();
flush();
readfile($filename);
unlink($filename);
exit;

?>