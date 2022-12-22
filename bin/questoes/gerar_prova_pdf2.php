<?php
	require_once "../../lib/conexao.php";
	// require_once "../../lib/html2pdf/html2pdf.class.php";



	/*
	// gerando o pdf
	$html2pdf = new HTML2PDF('P','A4','pt', false, 'ISO-8859-15', 2);
    $html2pdf->WriteHTML("
	<!DOCTYPE html>
	<html>
	<head>
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
		<link rel=\"stylesheet\" href=\"../../lib/bootstrap/css/bootstrap.min.css\">
	</head>
	<body>".utf8_decode($_POST['prova'])."</body></html>"); 
    $html2pdf->Output('optativa.pdf');
*/

	$html = "
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset=\"utf-8\">
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
		<link rel=\"stylesheet\" href=\"../../lib/bootstrap/css/bootstrap.min.css\">
	</head>
	<body>".$_POST['prova']."</body></html>";
    echo $html;
    

	

?>