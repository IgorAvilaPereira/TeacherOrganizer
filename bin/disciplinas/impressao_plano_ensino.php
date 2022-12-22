<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
	// ob_start();
	
	$template = new Template("../../view/disciplinas/impressao_plano_ensino.html");
	
	/*
	$sql = "update disciplinas set plano_ensino = '".pg_escape_string($_POST['tudo'])."' where id = ".$_GET['id_disciplina'].";";

	$result = pg_query($sql) or die($sql);

	header("Location: index.php?id=".$_GET['id_curso']);


	*/

	$template->tudo = $_POST['tudo'];
	$template->nome_disciplina = $_POST['nome_disciplina'];
	$template->show();

	// $html2pdf = new HTML2PDF('L','A4','pt', false, 'ISO-8859-15', 2);
 //    $html2pdf->WriteHTML($template->parse());
 //    $html2pdf->Output('plano_ensino.pdf');		
?>