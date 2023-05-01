# Teacher Organizer

Sistema de Gerenciamento para Professores: controle de presenças, controle de avaliações, relatórios de notas, diários de classe e etc.

## Requisitos:

* PHP 8.1.2
* PostgreSQL 14.5
* php-pgsql 
* [Templates](https://raelcunha.com/template/)
* Bootstrap
* jQuery
* Ajustar o __php.ini__ para receber arquivos via upload

## Instalação:

Dar permissão ao diretório zip: 

No terminal:
```sh
sudo chmod 777 -R zip/
```

Restaurar ***dump*** no PostgreSQL:

No terminal:
```sh
psql -h localhost -U postgres
\i dumps/docente22122022.sql
```

Iniciar o Teacher Organizer:

No terminal:
```sh
./start.sh
```

Acessar http://localhost:8081

## Setup:

* Desenvolvido no Linux Mint 21 x86_64 
