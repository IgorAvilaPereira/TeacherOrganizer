<?php
	require_once "../../lib/conexao.php";	
	require_once "../../lib/Template.php";
	use raelgc\view\Template;
	
	$template = new Template("../../view/planos/tela_alterar.html");
	
	$sql = "select * from planos where id = $1";
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $sql, array($_GET['id'])) or die ($sql);

	$registro = pg_fetch_array($result);
	$id_disciplina = $registro['disciplina_id'];
	$template->plano_id = $registro['id'];
	$template->data_hidden = $registro['data'];
	$template->data = explode("-",$registro['data'])[2]."/".explode("-",$registro['data'])[1]."/".explode("-",$registro['data'])[0];
	$template->texto = $registro['texto'];
	$template->id_disciplina = $registro['disciplina_id'];	
	$template->max_bimestre = (($registro['bimestre'] > 0) ? $registro['bimestre'] : 1) ;	

	
	$sql = "select * from disciplinas where id = $1";
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $sql, array($id_disciplina)) or die ($sql);
	$auxNomeDisciplina = pg_fetch_array($result);
	$template->nome_disciplina = $auxNomeDisciplina['nome'];	

	$sql = "select *, presencas.id as presenca_id
		from presencas left join alunos on (alunos.id = presencas.aluno_id) 
		where presencas.disciplina_id = $1 and data = $2 order by alunos.nome";		
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $sql, array($id_disciplina, $registro['data'])) or die ($sql);
	if (pg_affected_rows($result) > 0){
		$template->nome_select_alunos = "vetPresenca";
		while ($registro = pg_fetch_array($result)){
			$creditos = $registro['creditos'];
			// neste caso o id eh de presenca
            if ($registro['aluno_id'] != null) {
                $template->id = $registro['presenca_id'];
                $template->nome = nl2br($registro['nome']);
                // echo $registro['resultado'];
                $template->resultado = (($registro['resultado'] == 1) ? "checked" : "");
                $template->block("alunos");
            }
		}	
	} /*else {		
		$sql = "select alunos.nome, disciplinas.creditos_por_dia, alunos.id from alunos  
			inner join disciplinas on (disciplinas.id = alunos.disciplina_id)
		where 
			disciplina_id = ".$id_disciplina." order by alunos.matricula";	
		$result = pg_query($sql);	
		if (pg_affected_rows($result) > 0){
			$template->nome_select_alunos = "vetAluno";
			while ($registro = pg_fetch_array($result)){
				$creditos = $registro['creditos_por_dia'];	
				// neste caso o id eh de aluno
				$template->id = $registro['id'];
				$template->nome = nl2br($registro['nome']);
				$template->resultado = "";		
				$template->block("alunos");
			}
		}	
	}*/

	if (!isset($creditos)){
		$sql = "select * from disciplinas where id = $1";
		// $result = pg_query($sql) or die($sql);
		$result = pg_query_params($conexao, $sql, array($id_disciplina)) or die ($sql);
		$registro = pg_fetch_array($result);
		$creditos = $registro['creditos'];
	}

	// $sql = "select * from creditos where disciplina_id = ".$id_disciplina;
	$sql = "select distinct nr_creditos from creditos where disciplina_id = $1";
	// $result = pg_query($sql) or die($sql);
	$result = pg_query_params($conexao, $sql, array($id_disciplina)) or die ($sql);

	$html = "";
	if (pg_affected_rows($result) > 0) {
		// casos novos = creditos totais devem ser distribuidos por dia
		$html = "<select id='combo_creditos' name='creditos'>";
		while ($vetCredito = pg_fetch_array($result)) {
			$html.= "<option value=".$vetCredito['nr_creditos']." ".(($creditos == $vetCredito['nr_creditos']) ? 'selected' : '')." >".$vetCredito['nr_creditos']."</option>";
		}
		// no caso de creditos extras (fora do padrão da disciplina)
		$pos = strripos($html, "selected");
		if ($pos === false) {
			$html.= "<option value=".$creditos." selected >".$creditos."</option>";
		}		
		$html.="</select>";
	} else {
		// se n for distribuido por dia => casos antigos
		$sql = "select * from disciplinas where disciplina_id = $1";
		// $result = pg_query($sql) or die($sql);
		$result = pg_query_params($conexao, $sql, array($id_disciplina)) or die ($sql);
		if (pg_affected_rows($result) > 0) {
			$html = "<input type='text' value=".$vetCredito['creditos'].">";
		}
	}
	$template->html = $html;
	$template->show();
?>