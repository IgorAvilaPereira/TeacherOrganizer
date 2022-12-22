<?php
  require_once "../../lib/conexao.php";

  // echo "<pre>";
  
  // print_r($_FILES['arquivos']);

  // echo "</pre>";

  // die();

  // dirname($_FILEarquivos[]);


//  $pasta = "/home/iapereira/Imagens";
//  $nome = "aula.tex";

// caso haja problemas de preenchimento do latex
$nome = ((!isset($_POST['nome']) || (strlen($_POST['nome']) == 0)) ? "aula.tex" : trim($_POST['nome']).".tex");

$pasta = ((!isset($_POST['pasta']) || (strlen($_POST['pasta']) == 0)) ? "" : $_POST['pasta']);

$com_sem_section = ((!isset($_POST['com_sem_section']) || (strlen($_POST['com_sem_section']) == 0)) ? false : true);


if (strlen($pasta) == 0) {
    die("pasta incorreta");
}

    // inicio do latex
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
    // imagens permitidas
    $types = array( 'png', 'jpg', 'jpeg');
  

        if ($handle = opendir($pasta)) {
            while ($entry = readdir($handle)) {
                $ext = strtolower(pathinfo($entry, PATHINFO_EXTENSION));
      
                if (in_array($ext, $types)) {
                    $x = array(".png", ".jpg", ".jpeg", "_");
                    $y = array("","","", " ");


                    $w = array(".png", ".jpg", ".jpeg");
                    $z = array("","","");

                    if ($com_sem_section) {
                        // com section - cada imagem terá uma seção
                        $latex .= "\n\n"
                 . " \\section{".str_replace($x, $y, $entry)."}  \n\n";
                    }
                    $latex .= "\n\n"
                  . " \\begin{frame} \n"
                  . "\\frametitle{".str_replace($x, $y, $entry). "}\n"
                  . "\\begin{figure}\n"
                  . "\\centering\n"
                  . "\\includegraphics[width=1\\linewidth]{" . $pasta."/".$entry. "}\n"
                  . "\\caption{". str_replace($x, $y, $entry). "}\n"
                  . "\\label{fig:". strtolower(str_replace($w, $z, $entry)). "}\n"
                  . "\\end{figure}\n"
                  . "\\end{frame} \n\n";
                }
            }
            closedir($handle);

            // finalizando o latex
            $latex .= ""
            . "{%\\usebackgroundtemplate{}}\n"
            . "\\begin{frame}[plain]\n"
            . "\\titlepage \n"
            . "	\\end{frame}\n"
            . "\\end{document}";

            // exibindo o latex para download
            header("Content-Type: plain/text");
            header("Content-disposition: attachment; filename=$nome");
            header("Content-Transfer-Encoding: binary");
            header("Pragma: no-cache");
            header("Expires: 0");
    
            echo utf8_decode($latex);
        }   
?>