<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/disciplinas/tela_copiar.html");
	
	// $query = "select * from disciplinas inner join cursos on (cursos.id = disciplinas.curso_id) where curso_id = ".$_GET['id'];
	$query = "select * from disciplinas WHERE curso_id = $1 order by ano desc, semestre desc";
	// $result = pg_query($query);
	$result = pg_query_params($conexao, $query, array($_GET['id'])) or die ($query);

	if (pg_affected_rows($result) > 0 ){	
		while($registro = pg_fetch_array($result)) {
			$template->id = $registro['id'];
			$template->nome = strtoupper($registro['nome']);
			$template->ano = $registro['ano'];
			// $template->cor = (($registro['ano'] == $ano && $registro['semestre'] == $semestre) ? "black" : "#C0C0C0");
			$template->semestre = $registro['semestre'];			
			$template->block("disciplinas");
		}
	} else {
		$template->mensagem = "Nenhuma Disciplina cadastrada";
	}	
	$template->show();	
	
?>