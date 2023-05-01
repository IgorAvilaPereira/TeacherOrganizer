<?php
require_once "../../lib/conexao.php";

$data = $_POST['data'];
$bimestre = ((empty($_POST['bimestre'])) ? 1 : $_POST['bimestre']);

$sql = "select * from disciplinas where id = $1";
$result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);
$disciplina = pg_fetch_array($result);
$total = (($disciplina['eh_semestral'] == 't') ? 2 : 4);
$vetBimestre = array();
for ($i = 1; $i <= $total; $i++) {
	$vetBimestre[] = $i;
}

// presencas
$sql = "select id from alunos where disciplina_id = $1";
$result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);
$sql = "";
if (pg_affected_rows($result) > 0) {
	while ($registro = pg_fetch_array($result)) {
		$sql_x = "select * from presencas where disciplina_id = $1 and aluno_id = $2 
		and data = $3 and bimestre in (" . implode(",", $vetBimestre) . ");";
		$x = pg_query_params($conexao, $sql_x, array($_GET['id_disciplina'], $registro['id'], $data)) or die ($sql_x);

		if (pg_affected_rows($x) == 0) {
			// PRIMERO MOMENTO: todo mundo recebe AUSENCIA, neste dia, para esta disciplina, neste bimestre
			$sql = "insert into presencas (disciplina_id, aluno_id, data, resultado , bimestre, creditos) 
				values ($1, $2, $3, 0, $4 , $5);";
			$resultSQL = pg_query_params($conexao, $sql, array($_GET['id_disciplina'], $registro['id'], $data, $bimestre, ((isset($_POST['creditos']) && !empty($_POST['creditos'])) ? $_POST['creditos'] : NULL))) or die ($sql);	
		}
	}
	
	// CASO HAJA PRESENCA A SER CADASTRADA
	// if (strlen($sql) > 0){
	// 	// $result = pg_query("begin;" . $sql . "commit;") or die("begin;" . $sql . "commit;");
	// 	$result = pg_query_params($conexao, "begin;" . $sql . "commit;", array()) or die ("begin;" . $sql . "commit;");
	// }

	// PRIMERO MOMENTO: todo mundo recebe AUSENCIA, neste dia, para esta disciplina, neste bimestre
	$sql = "update presencas 
			set 
				resultado = 0,
				creditos = $1
			where
				disciplina_id = $2
			and 
				data = $3
			and 
				bimestre = $4";
	$result = pg_query_params($conexao, $sql, array($_POST['creditos'], $_GET['id_disciplina'], $data,  $bimestre)) or die ($sql);


	// SEGUNDO MOMENTO: depois quem foi selecionado, recebe a atualizacao, ou seja, PRESENCA.
	$sql = "";
	if (isset($_POST['vetPresenca'])) {
		$sql = "update presencas 
			set 
				resultado = 1 
			where
				disciplina_id = $1 
			and 
				aluno_id in (" . implode(",", $_POST['vetPresenca']) . ")
			and 
				data = $2
			and 
				bimestre = $3";
		$result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'], $data, $bimestre)) or die ($sql);
	}
}

	// testa se ja existe um plano, anteriormente, cadastrado	
	$sql = "SELECT id FROM planos 
			where  
				data = $1 and 
				disciplina_id = $2 and 
				bimestre = $3"; 	
	$result = pg_query_params($conexao, $sql, array($data,$_GET['id_disciplina'],$bimestre)) or die ($sql);
	//  caso exista, pega o id
	if (pg_affected_rows($result) > 0) {
		$registro = pg_fetch_array($result); 
		$plano_id = $registro['id'];
		// print_r("<script>alert('existe um plano com esta data'); </script>");
	} else {
		// senao existe, cadastra
		$sql = "INSERT INTO planos (
			data, 
			texto, 
			disciplina_id, 
			bimestre
		)
	    VALUES (
	    	$1, 
	    	'-',
	    	$2, 
	    	$3) 
	    RETURNING id;";
		$result = pg_query_params($conexao, $sql, array($data,$_GET['id_disciplina'], $bimestre)) or die ($sql);
		$registro = pg_fetch_array($result); 
		$plano_id = $registro['id'];		
	}
	header("Location: ../planos/tela_alterar.php?id=" . $plano_id);


// tela_inserir planos de aula
//$sql = "SELECT * FROM planos where data = '".$data."' and disciplina_id = ".$_GET['id_disciplina'];
//$result = pg_query($sql) or die($sql);
//if (pg_affected_rows($result) > 0) {
//header("Location: ../planos/tela_inserir.php?id_disciplina=" . $_GET['id_disciplina'] . "&data=" . $data);
//} else {
//header("Location: ../disciplinas/ver.php?id_disciplina=".$_GET['id_disciplina']);
//}
?>