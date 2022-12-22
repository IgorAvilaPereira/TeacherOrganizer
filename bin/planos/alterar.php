<?php
require_once "../../lib/conexao.php";

if (!isset($_POST['creditos']) || $_POST['creditos'] <= 0) {
    print_r("<script>
			alert('Creditos com valores incorretos!'); 
			location.href='tela_alterar.php?id=".$_POST['plano_id']."';
		</script>");
} else {
	// 1º) altera a tupla dos planos
	$sql = "update planos set
			texto = '" . trim($_POST['texto']) . "',
			bimestre = " . $_POST['bimestre'] . "
		where
			id = " . $_POST['plano_id'] . ";";
	// $result = pg_query() or die($sql);
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);


	// 2º) dah falta para todos naquele dia com os novos valores de bim. e creditos
	$sql = "UPDATE presencas SET
					resultado = 0,
					bimestre = " . $_POST['bimestre'] . " ,
					creditos = " . $_POST['creditos'] . "					
				WHERE
					data = '" . trim($_POST['data_hidden']) . "'
					AND disciplina_id = " . $_POST['id_disciplina'] . ";";
//    die($sql);
	// $result = pg_query("BEGIN;" . $sql . "COMMIT;") or die($sql);
	$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	// 3º) se algum aluno tiver presença...
	if (isset($_POST['vetPresenca'])) {
		// e re-coloca presenca somente nos selecionados
		$sql = "UPDATE presencas
					set
						resultado = 1
					where
						id in (" . implode(",", $_POST['vetPresenca']) . ");";

		// $result = pg_query("BEGIN;" . $sql . "COMMIT;") or die($sql);
		$result = pg_query_params($conexao, $sql, array()) or die ($sql);

	} 
	header("Location: ../disciplinas/ver.php?id_disciplina=" . $_POST['id_disciplina']);
}
?>
