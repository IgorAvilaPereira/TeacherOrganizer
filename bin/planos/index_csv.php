<?php
	require_once "../../lib/conexao.php";

	$query = "select *, planos.id as id from planos inner join disciplinas on (disciplinas.id = planos.disciplina_id) where disciplina_id = $1 ORDER BY data";
	// $result = pg_query($sql);
	$result = pg_query_params($conexao, $query, array($_GET['id_disciplina'])) or die ($query);
	
	$arquivo = "";
	$aulas = 0;

	while ($registro = pg_fetch_array($result)){	
		$arquivo.= $registro['bimestre'].";";
		$data = explode("-", $registro['data']);
		$arquivo.= $data[2]."/".$data[1]."/".$data[0].";";
		// pra colocar aspas entre a aspa
		$arquivo.= addslashes($registro['texto']).";";		
		// $arquivo.= $registro['texto'].";";		
		$arquivo.= "\\n";

		$aulas++;

		$sqlCreditos = "SELECT creditos FROM presencas WHERE data = $1 and disciplina_id = $2 limit 1;";
		// $resultadoCreditos = pg_query($sqlCreditos);
		$resultadoCreditos = pg_query_params($conexao, $sqlCreditos, array($registro['data'], $_GET['id_disciplina'])) or die ($sqlCreditos);

		$registroCreditos = pg_fetch_array($resultadoCreditos);
		
		// qtde de linhas - 1 que devem ser replicadas
		$creditos = $registroCreditos['creditos'];
		
		for ($i = 0; $i < $creditos-1; $i++) { 
			$arquivo.= $registro['bimestre'].";";
			$data = explode("-", $registro['data']);
			$arquivo.= $data[2]."/".$data[1]."/".$data[0].";";
			// pra colocar aspas entre a aspa
			$arquivo.= addslashes($registro['texto']).";";		
			// $arquivo.= $registro['texto'].";";		
			$arquivo.= "\\n";				
			$aulas++;
		}
		//$arquivo.= "<br>";		
	}
	echo "var diario = \"".$arquivo."\";";
	// echo "<br><br>";
	// echo "Total aulas dadas:".$aulas;

// $codigo = "var diario = \"".$arquivo."\"; <br>";
// $codigo.= "var vetDiario = diario.split(\"\n\"); <br>
// var qtde = vetDiario.length; <br>
// var i = 0; <br>
// while(i < qtde){ <br>
//     linha = vetDiario[i].split(\";\"); <br>
//     if (linha.length != 1){ <br>
//         etapa = linha[0]; <br>
//         data = linha[1]; <br>
//         atividade = linha[2]; <br>        
//         document.querySelector(\"#sia3app\").querySelector(\"#frame_aplicacao\").contentWindow.document.querySelector('#cd_etapa_'+(i+1)).innerHTML = \"<select name='cd_etapa[]' style='width:60px'><option value='\"+etapa+\"'>\"+etapa+\"</option></select>\"; <br>
//         document.querySelector(\"#sia3app\").querySelector(\"#frame_aplicacao\").contentWindow.document.querySelector('#dt_prevista_'+(i+1)).innerHTML = \"<input name='dt_prevista[]' type='text' class='mascData hasDatepicker' value='\"+data+\"' style='width: 90px; text-align: center;' maxlength='10'>\"; <br>
//         document.querySelector(\"#sia3app\").querySelector(\"#frame_aplicacao\").contentWindow.document.querySelector('#ds_atividade_'+(i+1)).innerHTML = \"<input name='ds_atividade[]' type='text' value='\"+atividade+\"' style='width:690px'>\"; <br>
//     } <br>
//     i++; <br>
// }";

// echo $codigo;

?>	