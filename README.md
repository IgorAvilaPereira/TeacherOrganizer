# Teacher Organizer

Sistema de gerenciamento para professores, oferecendo funcionalidades como controle de presenças, avaliações, relatórios de notas e diários de classe.

## Funcionalidades

* **Controle de Presenças**: Registre e acompanhe a frequência dos alunos.
* **Avaliações**: Gerencie e registre notas de avaliações realizadas.
* **Relatórios de Notas**: Gere relatórios detalhados de desempenho dos alunos.
* **Diário de Classe**: Mantenha um registro das atividades e conteúdos ministrados.

## Tecnologias Utilizadas

* **PHP 8.1.2**: Linguagem de script do lado servidor.
* **PostgreSQL 14.5**: Sistema de gerenciamento de banco de dados.
* **php-pgsql**: Extensão PHP para PostgreSQL.
* **Templates**: Sistema de templates para renderização de views.
* **Bootstrap**: Framework front-end para design responsivo.
* **jQuery**: Biblioteca JavaScript para manipulação do DOM.

## Instalação

1. **Ajustar permissões do diretório `zip/`**:

   No terminal, execute:

   ```bash
   sudo chmod 777 -R zip/
   ```



2. **Restaurar o dump no PostgreSQL**:

   No terminal, execute:

   ```bash
   psql -h localhost -U postgres
   \i dumps/docente22122022.sql
   ```



3. **Iniciar o Teacher Organizer**:

   No terminal, execute:

   ```bash
   ./start.sh
   ```



4. **Acessar a aplicação**:

   Abra o navegador e acesse:

   ```
   http://localhost:8081
   ```



## Ambiente de Desenvolvimento

Este sistema foi desenvolvido no Linux Mint 21 x86\_64.

## Licença

Este projeto está licenciado sob a Licença MIT.



## Setup:

* Desenvolvido no Linux Mint 21 x86_64 
