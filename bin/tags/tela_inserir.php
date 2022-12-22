<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/tags/tela_inserir.html");
	
	/*
	$sql = "select *, questoes.id as questaoid from questoes left join questoes_tags on (questoes.id = questoes_tags.questao_id) left join tags on (questoes_tags.tag_id = tags.id);";
	$result = pg_query($sql);	

	while ($registro = pg_fetch_array($result)){
		$template->questao = nl2br($registro['questao']);
		$template->resposta = nl2br($registro['resposta']);
		$template->id = $registro['questaoid'];
		$template->block("questoes");
	}*/	



	$template->show();
?>