<?php
	require_once "../../lib/conexao.php";
	// require_once "../../lib/html2pdf/html2pdf.class.php";

	$html = "
	<!DOCTYPE html>
	<html>
	<head>
		<meta charset=\"utf-8\">
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
		<link rel=\"stylesheet\" href=\"../../lib/bootstrap/css/bootstrap.min.css\">
	</head>
	<body>".$_POST['prova']."</body></html>";

	if (isset($_POST['botao2'])){
		/*
		// gerando o pdf
	$html2pdf = new HTML2PDF('P','A4','pt', false, 'ISO-8859-15', 2);
	$html2pdf->setDefaultFont("arial");
	    $html2pdf->WriteHTML("<!DOCTYPE html>
	<html>
	<head>
		<meta charset=\"utf-8\">
		<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
		<link rel=\"stylesheet\" href=\"../../lib/bootstrap/css/bootstrap.min.css\">
	</head>
	<body>".utf8_decode($_POST['prova'])."</body></html>"); 
	    $html2pdf->Output('optativa.pdf');

	 } else {

*/
    	echo $html;
  
    } else {    	
    	$query = "INSERT INTO provas (nome, exercicios, data_hora) values ('".$_POST['disciplina']."','".$html."', now());";
    	$result = pg_query_params($conexao, $query, array()) or die ($query);
    	echo "<h1> Salvo </h1>";
    	
    	//header("Location: ./../provas/index.php");
    	
    }	


?>