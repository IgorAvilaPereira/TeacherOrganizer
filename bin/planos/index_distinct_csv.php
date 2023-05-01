<?php
	require_once "../../lib/conexao.php";

	//1;10/03/2017;Atividades para este horário
	//1;10/03/2017;Atividades para este horário
	//1;17/03/2017;Atividades para este horário	

	$vetSemana = array('Semana 10', 'Semana 11', 'Semana 12', 'Semana 13','Semana 0','Semana 1', 'Semana 2', 'Semana 3', 'Semana 4', 'Semana 5', 'Semana 6', 'Semana 7', 'Semana 8', 'Semana 9');
	$query = "select *, planos.id as id from planos inner join disciplinas on (disciplinas.id = planos.disciplina_id) where disciplina_id = $1 ORDER BY data";
	// $result = pg_query($sql);	
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);

	$arquivo = "";
	// $aulas = 0;
	while ($registro = pg_fetch_array($result)){		
		$arquivo.= $registro['bimestre'].";";
		$data = explode("-", $registro['data']);
		$arquivo.= $data[2]."/".$data[1]."/".$data[0].";";
		// $arquivo.= $registro['texto'].";";		
		$arquivo.= str_replace($vetSemana, "", $registro['texto']).";";				
		$arquivo.= "<br>";

		// $aulas++;

		// $sqlCreditos = "SELECT creditos FROM presencas WHERE data = '".$registro['data']."' and disciplina_id = ".$_GET['id_disciplina']." limit 1;";
		// $resultadoCreditos = pg_query($sqlCreditos);
		// $registroCreditos = pg_fetch_array($resultadoCreditos);
		
		// // qtde de linhas - 1 que devem ser replicadas
		// $creditos = $registroCreditos['creditos'];
		
		// for ($i = 0; $i < $creditos-1; $i++) { 
		// 		$arquivo.= $registro['bimestre'].";";
		// 		$data = explode("-", $registro['data']);
		// 		$arquivo.= $data[2]."/".$data[1]."/".$data[0].";";
		// 		$arquivo.= $registro['texto'].";";		
		// 		$arquivo.= "<br>";
				
		// 		$aulas++;
		// }
		//$arquivo.= "<br>";		
	}
	echo $arquivo;
	// echo "<br>";
	// echo "Total aulas dadas:".$aulas;
?>	