<?php
// ==================================================================
// para mostrar os erros no navegador
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
// ==================================================================
// start na sessao
session_start();
// if (!isset($_SESSION['login'])){
//     header("Location ./../bin/usurio/index.php");
// }
// ==================================================================
// tamanho dos arquivos nos upload
// sudo nano /etc/php/8.0/cli/php.ini
// upload_max_filesize
// ==================================================================
define("URL", "http://localhost:8081/");
define("DIR", "/home/iapereira/Dropbox/ifrs/docente-projeto-pessoal/docente/");
// ==================================================================
// Permitir somente Minha Placa de Rede
// $resultado = shell_exec("ip -brief link");
// $resultado = shell_exec("ifconfig"); // tb funciona
// $resultado = explode(" ", $resultado);
// echo "<pre>";
//     print_r($resultado[47]);
//     print_r("<br>");
//     print_r($resultado[75]);
//     print_r("<br>");
//     print_r($_SERVER["SCRIPT_FILENAME"]);
//     print_r("<br>");
//     print_r($_SERVER["DOCUMENT_ROOT"]);
//     print_r("<br>");
//     print_r(explode("/", DIR)[2]);
// echo "</pre>";
// inspiron 5000
// if (!(in_array("6c:2b:59:59:f2:39", $resultado) && in_array("04:ea:56:8e:3f:cd", $resultado))) {
//     die("ACESSO NÃO PERMITIDO - NÃO É UM COMPUTADOR PERMITIDO.");
// }
//aspire 5 e inspiron 5000
// if(!(in_array("70:69:79:a7:cf:e2", $resultado) && in_array("20:1e:88:69:2d:32", $resultado)) && !(in_array("6c:2b:59:59:f2:39", $resultado) && in_array("04:ea:56:8e:3f:cd", $resultado))) {
// if(!(in_array("5c:f9:dd:5a:c5:fc", $resultado) && in_array("60:6c:66:24:fe:41", $resultado)) && !(in_array("70:69:79:a7:cf:e2", $resultado) && in_array("20:1e:88:69:2d:32", $resultado)) && !(in_array("6c:2b:59:59:f2:39", $resultado) && in_array("04:ea:56:8e:3f:cd", $resultado))) {
//     die("ACESSO NÃO PERMITIDO - NÃO É UM COMPUTADOR PERMITIDO.");
// }
// ==================================================================
// Permitir Somente Acesso Local/Com o usuario iapereira
// $resultado = shell_exec("whoami");
// if (strcmp(explode("/", DIR)[2], trim($resultado)) !== 0 || strcmp($_SERVER["REMOTE_ADDR"], "127.0.0.1") != 0 || !(strpos($_SERVER["SCRIPT_FILENAME"], trim($resultado)) !== false) || !(strpos($_SERVER["DOCUMENT_ROOT"], trim($resultado)) !== false)) {
//     die("ACESSO NÃO PERMITIDO - NÃO É UMA CONTA LOCAL.");
// }
//========================================================================
// Banco - trocar senha padrao postgres
// https://www.vivaolinux.com.br/dica/Alterando-senha-inicial-do-PostgreSQL-[Ubuntu]
// Banco - Parametros
$usuario = "postgres";
$senha = "postgres";
$banco = "docente";
$HOST = "localhost";
$porta = 5432;
// string de conexao
$connection_string = "host=$HOST port=$porta user=$usuario password=$senha dbname=$banco";
// realizando a conexao
$conexao = pg_connect($connection_string) or die("Falha em conectar - Banco de Dados....");

function dump() {
    global $banco, $senha, $porta, $HOST, $usuario;
    $path_back = DIR."dumps/";
    //  funcionando mas preferi retirar - apagando todos os dumps anteriores
    $link = $path_back . $banco . date("dmY") . ".sql";
    $cmd = "PGPASSWORD=" . $senha . " pg_dump --host " . $HOST . " --port " . $porta . " --username " . $usuario . " --format plain --create --clean --inserts --verbose --file " . $link . " " . $banco;
    // criando um novo dump atualizado => Executa o comando pg_dump que esta na variável cmd
    shell_exec($cmd);
    
    // removendo dumps velhos (Mantem somente os ultimos)
    $vetArquivo = explode("\n",shell_exec("cd ".$path_back." && ls -alt | grep \"docente*\" | awk '{print $(NF)}'"));
    $x = 7;
    if (count($vetArquivo) > $x){
        for ($i=$x; $i < count($vetArquivo); $i++) { 
            if (strlen($vetArquivo[$i]) > 0){
                unlink($path_back.trim($vetArquivo[$i]));
            }
        }
    }
    // Compacta o arquivo gerado pelo camando para tar.gz
    // shell_exec("tar -zcf ".$path_back.$banco.date("Ymd").".sql ".$path_back."*");
    // As linhas abaixo forçam o download do arquivo
    //header ("Content-Disposition: attachment; filename=".$banco.date("dmY").".sql");
    //header ("Content-Type: application/octet-stream");
    //header ("Content-Length: ".filesize($link));
    //readfile($link);
    // Apaga o arquivo gerado
    //shell_exec("rm -rf ".$path_back."*");
    //email();
}



// Funcao que realiza o dump do banco - tentando
/*
function dump() {
    global $banco, $senha, $porta, $HOST, $usuario;    
    $notebook_atual = shell_exec("hostname");
    $notebook_ultimo_dump = shell_exec("cat ./../dumps/log.txt");
    $path_back = DIR."dumps/";   
    //  funcionando mas preferi retirar - apagando todos os dumps anteriores
    // shell_exec("rm ".$path_back."*");
    $link = $path_back . $banco . date("dmY") . ".sql";
    // removendo dumps velhos (Mantem somente os ultimos)
    $vetArquivo = explode("\n",shell_exec("cd ".$path_back." && ls -alt | grep \"docente*\" | awk '{print $(NF)}'"));
    //  são diferentes
    if (strcmp($notebook_atual, $notebook_ultimo_dump) !== 0) {
        echo "Recuperando o dump:".$vetArquivo[0]." de ".$notebook_ultimo_dump."<br>";
        shell_exec("PGPASSWORD=postgres psql -h localhost -U postgres -c 'ALTER DATABASE docente RENAME TO docente'".date("dmY")."'");
        shell_exec("PGPASSWORD=".$senha." psql -h ".$HOST." -U ".$usuario." -d ".$banco. " < ".$path_back.$vetArquivo[0]);
        shell_exec("hostname > ./../dumps/log.txt");
    }
    $cmd = "PGPASSWORD=" . $senha . " pg_dump --host " . $HOST . " --port " . $porta . " --username " . $usuario . " --format plain --create --clean --inserts --verbose --file " . $link . " " . $banco;
    $vetArquivo = explode("\n",shell_exec("cd ".$path_back." && ls -alt | grep \"docente*\" | awk '{print $(NF)}'"));
    // criando um novo dump atualizado => Executa o comando pg_dump que esta na variável cmd
    shell_exec($cmd);
    $x = 7;
    if (count($vetArquivo) > $x){
        for ($i=$x; $i < count($vetArquivo); $i++) { 
            if (strlen($vetArquivo[$i]) > 0){
                unlink($path_back.trim($vetArquivo[$i]));
            }
        }
    }
    // Compacta o arquivo gerado pelo camando para tar.gz
    // shell_exec("tar -zcf ".$path_back.$banco.date("Ymd").".sql ".$path_back."*");
    // As linhas abaixo forçam o download do arquivo
    //header ("Content-Disposition: attachment; filename=".$banco.date("dmY").".sql");
    //header ("Content-Type: application/octet-stream");
    //header ("Content-Length: ".filesize($link));
    //readfile($link);
    // Apaga o arquivo gerado
    //shell_exec("rm -rf ".$path_back."*");
    //email();
}*/


// ==================================================================
// nao testada
// function diaDaSemana($dia) {
// 	//$dia="22/03/2010";
// 	$diaa = substr($dia, 0, 2) . "-";
// 	$mes = substr($dia, 3, 2) . "-";
// 	$ano = substr($dia, 6, 4);
// 	$diasemana = date("w", mktime(0, 0, 0, $mes, $diaa, $ano));
// 	return $diasemana;
// }
// function zipar_docente($nome){
//     // Dropbox => FUNCIONANDO
//     // shell_exec("zip -r  ".DIR_DROPBOX."ifrs/docente-backups/docente". date("dmY_Hi").".zip ".DIR);
//     // Mega => FUNCIONANDO
//     // shell_exec("zip -r  ".DIR_MEGA."ifrs/docente-backups/docente". date("dmY_Hi").".zip ".DIR);
//     // Google Drive => FUNCIONANDO
//     $path_back = DIR_GDRIVE."ifrs/docente-backups/";
//     shell_exec("zip -r  ".$path_back.$nome.".zip ".DIR);
//     // removendo dumps velhos (Mantem somente os ultimos)
//     $vetArquivo = explode("\n", shell_exec("cd ".$path_back." && ls -alt | grep \"docente*\" | awk '{print $(NF)}'"));
//     $x = 15;
//     if (count($vetArquivo) > $x) {
//         for ($i=$x; $i < count($vetArquivo); $i++) {
//             if (strlen($vetArquivo[$i]) > 0) {
//                 // try {
//                 unlink(DIR_GDRIVE_WITHOUT_FORMAT."ifrs/docente-backups/".trim($vetArquivo[$i]));
//                 // } catch(Exception $e) {
//                 // echo "nops!!! <br>";
//             // }
//             }
//         }
//     }
//     echo "ok";
// }


?>
