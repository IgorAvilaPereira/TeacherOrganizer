<?php 
	require_once 'conexao.php';
	
	$handle = fopen("so.csv", "r");
	$disciplina_id = 3;	
		
	$query = "delete from presencas where disciplina_id = $disciplina_id;";
	pg_query($query);
	
	$query = "delete from alunos where disciplina_id = $disciplina_id;";
	pg_query($query);
		
	if ($handle) {
		$i = 0;
		$cabecalho;
		$vetData = array();
    	while (!feof($handle)) {
        	$buffer = fgets($handle, 4096);
			if ($i == 0) { 
        		$cabecalho = explode(",",$buffer);
				unset($cabecalho[0]);
				unset($cabecalho[1]);
				foreach ($cabecalho as $valor) {
					$data =  explode("/",$valor);
					$vetData[] = "20".trim($data[2])."-".trim($data[1])."-".trim($data[0]);
				}
				$vetData =  array_values($vetData);
				var_dump($vetData);
				//die();
				$i++;				
			} else {
				$sql = "";
				$aluno =  array();
				$aluno_id = "";
				
				$aluno = explode(",", $buffer);
				if (isset($aluno[0]) &&  isset($aluno[1])) {
					$matricula = trim($aluno[0]);
					$nome = trim($aluno[1]);
				} else {
					var_dump($aluno);
					die();
				}
				if (!isset($matricula) || empty($matricula) || (empty($nome)) || strlen($nome) < 3 ){
					die();
				}				
				unset($aluno[0]);
				unset($aluno[1]);				
				
				$resultado = $aluno;
				$resultado = array_values($resultado); 
				
				$query = "insert into alunos (matricula, nome, disciplina_id) values 
				('".trim($matricula)."','".trim($nome)."', $disciplina_id);";
				$y  = pg_query($query) or die($query);		
				
				$consulta = "select * from alunos where 
					matricula   = '".trim($matricula)."' and 
					disciplina_id = ".$disciplina_id;
					//echo $query."<br>";
					//die();
				$z  = pg_query($consulta) or die($consulta);	
				$x = pg_fetch_array($z); 
				var_dump($x);
				//echo $x['id'];
				$aluno_id = $x['id'];
											
				for ($x = 0; $x < count($vetData); $x++) {
					//if (!empty($aluno_id) && !isset($aluno_id)){
						$sql = "insert into presencas (data, aluno_id, disciplina_id, resultado)
					values ('".$vetData[$x]."', ".$aluno_id.", ".$disciplina_id.", ".((strtolower($resultado[$x]) == 'p') ? 1 : 0).");";
					$result  = pg_query($sql) or die($sql);
				//	} else {
						//echo "erro";
					//	die($aluno_id);
					//}					
				}
				//$result  = pg_query("begin;".$sql."commit;");
				
			}
    	}
    	fclose($handle);
	} 
?>
