<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
		
	$template = new Template("../../view/alunos/tela_alterar.html");
	
	$query = "select disciplinas.nome as disciplina, disciplinas.id as disciplina_id, alunos.id as id, alunos.matricula as matricula, alunos.nome as nome, alunos.observacao from alunos inner join disciplinas on (alunos.disciplina_id = disciplinas.id) where alunos.id = $1 order by matricula";
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);

	$aluno = pg_fetch_array($result);
	$template->id = $aluno['id'];
	$template->matricula = $aluno['matricula'];
	$template->nome = strtoupper($aluno['nome']);	
	$template->disciplina = $aluno['disciplina'];
	//$template->disciplina = utf8_decode($aluno['disciplina']);
	$disciplina_id  = $aluno['disciplina_id'];
	$template->observacao = $aluno['observacao'];
	
	$query = "select id, data, resultado, creditos from presencas where aluno_id = $1 order by data desc;";
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);

	while ($presenca = pg_fetch_array($result)){
			$template->presenca_id = $presenca['id'];
			$data = explode("-",$presenca['data']);	
			$template->data = $data[2]."/".$data[1]."/".$data[0];
			$template->creditos = $presenca['creditos'];
			$template->resultado = (($presenca['resultado'] == 1) ? "checked" : ""); 
			
			$queryTexto = "select texto from planos where data = $1 and disciplina_id = $2";			
			$reultTexto = pg_query_params($conexao, $queryTexto, array($presenca['data'], $disciplina_id)) or die ($queryTexto);

			$registroTexto = pg_fetch_array($reultTexto);
			$template->texto = substr($registroTexto['texto'], 0, 49)."...";

			$template->block("presenca");
	}	

	


	$template->disciplina_id = $aluno['disciplina_id'];
	$template->tela = ((isset($_GET['tela'])) ?  $aluno['disciplina_id'] : 0);	
	$template->show();
?>