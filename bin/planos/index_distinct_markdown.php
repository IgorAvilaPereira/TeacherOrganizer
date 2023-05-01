<?php
	require_once "../../lib/conexao.php";
	require_once "../../lib/TextTable.php";

	$query = "select * from disciplinas where id = $1";	
	// $result = pg_query($query);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	$registro = pg_fetch_array($result);
	
//	$template->id_disciplina = $registro['id'];
	//$template->nome_disciplina = utf8_decode($registro['nome']);
	$disciplina = $registro['nome'];
	$ano_semestre = $registro['ano']."/".$registro['semestre'];

	$sql = "select *, planos.id as id from planos inner join disciplinas on (disciplinas.id = planos.disciplina_id) where disciplina_id = $1 ORDER BY data";
	// $result = pg_query($sql);		
	$result = pg_query_params($conexao, $sql, array($_GET['id_disciplina'])) or die ($sql);

	
	$aulas = 0;
	$rowsFinal = [];
	$columns = ["Bim.", "Data", "Diário"];	
	$maxlen = 0;
	while ($registro = pg_fetch_array($result)){
		$data = explode("-", $registro['data']);				
		$rowsFinal[] = [$registro['bimestre'], $data[2]."/".$data[1]."/".$data[0], preg_replace('/\\s\\s+/', ' ', $registro['texto'])];
		$aulas++;

		if (strlen($registro['texto']) > $maxlen) {
			$maxlen = strlen($registro['texto']);
		}

		
		// $sqlCreditos = "SELECT creditos FROM presencas WHERE data = '".$registro['data']."' and disciplina_id = ".$_GET['id_disciplina']." limit 1;";
		// $resultadoCreditos = pg_query($sqlCreditos);
		// $registroCreditos = pg_fetch_array($resultadoCreditos);		
		// // qtde de linhas - 1 que devem ser replicadas
		// $creditos = $registroCreditos['creditos'];		
		// for ($i = 0; $i < $creditos-1; $i++) { 				
		// 	$rowsFinal[] = [$registro['bimestre'], $data[2]."/".$data[1]."/".$data[0], preg_replace('/\\s\\s+/', ' ', $registro['texto'])];	
		// 	$aulas++;
		// }
	}
	$t = new TextTable($columns);
	$t->maxlen = $maxlen;
	$t->addData($rowsFinal);
	// $t->setAlgin(['L', 'C', 'R']);
	echo "<html> <head> <title> ".utf8_encode($disciplina)." - ".$ano_semestre." - Diário de Classe - Markdown </title> </head> <body>";    
    echo utf8_decode("## ".$disciplina." - ".$ano_semestre)."<br><br>**Atualiza&ccedil;&atilde;o:** ".date("d/m/Y - H:i:s")."<br><br>";
	echo nl2br($t->render());
	// echo "<br>";
	// echo "Total aulas dadas:".$aulas;
	echo "</body></html>";
?>	