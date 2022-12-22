<?php
    require_once "../../lib/conexao.php";

    $bimestre = ((empty($_POST['bimestre'])) ? 1 : $_POST['bimestre']);
    $sql = "select * from disciplinas where id = " . $_POST['id_disciplina'];
    $result = pg_query($sql);
    $disciplina = pg_fetch_array($result);
    $total = (($disciplina['eh_semestral'] == 't') ? 2 : 4);
    $vetBimestre = array();
    for ($i = 1; $i <= $total; $i++) {
        $vetBimestre[] = $i;
    }

    $sql = "DELETE FROM planos WHERE id = ".$_POST['plano_id'].";";
    $sql.= "DELETE FROM presencas WHERE data = '".trim($_POST['data_hidden'])."' AND disciplina_id =".$_POST['id_disciplina'].";";
    $result = pg_query("BEGIN;".$sql."COMMIT;") or die($sql);
    

// presencas
$sql = "select id from alunos where disciplina_id = " . $_POST['id_disciplina'];
$result = pg_query($sql);
$sql = "";
if (pg_affected_rows($result) > 0) {
    while ($registro = pg_fetch_array($result)) {
        $sql_x = "select * from presencas where disciplina_id = " . $_POST['id_disciplina'] . " and aluno_id = " . $registro['id'] . " 
							and data = '" . $_POST['data'] . "' and bimestre in (" . implode(",", $vetBimestre) . ");";
        $x = pg_query($sql_x) or die($sql_x);
        if (pg_numrows($x) == 0) {
            // PRIMERO MOMENTO: todo mundo recebe AUSENCIA, neste dia, para esta disciplina, neste bimestre
            $sql.= "insert into presencas (disciplina_id, aluno_id, data, resultado , bimestre, creditos) 
				values (" . $_POST['id_disciplina'] . ", " . $registro['id'] . ", '" . $_POST['data'] . "', 0, " . $bimestre . ", ".((isset($_POST['creditos']) && !empty($_POST['creditos'])) ? $_POST['creditos'] : "NULL").");";
        }
    }
    
    // CASO HAJA PRESENCA A SER CADASTRADA
    if (strlen($sql) > 0) {
        $result = pg_query("begin;" . $sql . "commit;") or die("begin;" . $sql . "commit;");
    }

    // PRIMERO MOMENTO: todo mundo recebe AUSENCIA, neste dia, para esta disciplina, neste bimestre
    $sql = "update presencas 
			set 
				resultado = 0,
				creditos = ".$_POST['creditos']."
			where
				disciplina_id = " . $_POST['id_disciplina'] . " 
			and 
				data = '" . $_POST['data'] . "' 
			and 
				bimestre = " . $bimestre . ";";
    $result = pg_query($sql) or die($sql);

    // SEGUNDO MOMENTO: depois quem foi selecionado, recebe a atualizacao, ou seja, PRESENCA.
    $sql = "";
    if (isset($_POST['vetPresenca'])) {
        $sql = "update presencas 
			set 
				resultado = 1 
			where
				disciplina_id = " . $_POST['id_disciplina'] . " 
			and 
				aluno_id in (" . implode(",", $_POST['vetPresenca']) . ")
			and 
				data = '" . $_POST['data'] . "' 
			and 
				bimestre = " . $bimestre . ";";
        $result = pg_query($sql) or die($sql);
    }
}

    // testa se ja existe um plano, anteriormente, cadastrado
    $sql = "SELECT id FROM planos 
			where  
				data = '".$_POST['data']."' and 
				disciplina_id = ".$_POST['id_disciplina']." and 
				bimestre = ".$bimestre;
    $result = pg_query($sql) or die($sql);
    //  caso exista, pega o id
    if (pg_affected_rows($result) > 0) {
        $registro = pg_fetch_array($result);
        $plano_id = $registro['id'];
    // print_r("<script>alert('existe um plano com esta data'); </script>");
    } else {
        // se nao existe, cadastra
        $sql = "INSERT INTO planos (
			data, 
			texto, 
			disciplina_id, 
			bimestre
		)
	    VALUES (
	    	'".$_POST['data']."', 
	    	'-',
	    	".$_POST['id_disciplina'].", 
	    	".$bimestre.") 
	    RETURNING id;";
        $result = pg_query($sql);// or die($sql);
        $registro = pg_fetch_array($result);
        $plano_id = $registro['id'];
    }
    
    dump(); // realiza o dump com as presencas/ausencias do dia mais o plano recem cadastrado
    
    // volta a tela principal de detalhamento da disciplina
    header("Location: ../disciplinas/ver.php?id_disciplina=" . $_POST['id_disciplina']);
?>		