<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	// require_once "../../lib/html2pdf/html2pdf.class.php";
		
	$template = new Template("../../view/alunos/index.html");
	
	
	$query = "select * from disciplinas where id = ".$_GET['disciplina_id'];
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$disciplina = pg_fetch_array($result);
	$template->disciplina = $disciplina['nome'];
	$template->id_disciplina = $_GET['disciplina_id'];
	
	$query = "select * from alunos where disciplina_id = ".$_GET['disciplina_id']." order by matricula";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array()) or die ($query);
	$template->total = ((pg_affected_rows($result) > 0) ? "- ".pg_affected_rows($result)." Alunos" : "") ;
	
	while ($aluno = pg_fetch_array($result)) {
			$template->id = $aluno['id'];
			$template->matricula = $aluno['matricula'];
			$template->nome = strtoupper($aluno['nome']);
			$template->observacao = $aluno['observacao']; 
			$template->block("alunos");
	}	
	$template->show();

?>