<?php
    require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;	
	$template = new Template("../../view/avaliacoes/tela_gerar_planilha_avaliacao.html");
    $template->id_avaliacao = $_GET['id_avaliacao'];
    $template->id_disciplina = $_GET['id_disciplina'];
    $template->show();
?>