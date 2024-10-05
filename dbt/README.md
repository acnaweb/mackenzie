# dbt

Treinamento básico de dbt

## Preparação de Treinamento 

### Pré-requisitos

- [Docker](https://docs.docker.com/desktop/)
- [Python 3.8+](https://www.python.org/downloads/)
- [DBeaver](https://dbeaver.io/download/) ou outro SQL Client de preferencia
- Oracle Database

### Oracle

Script para criação de schemas (estudantes) "dbt_XX"

```sql
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

CREATE USER dbt_XX
IDENTIFIED BY senha_XX
DEFAULT TABLESPACE users
QUOTA UNLIMITED on users;

GRANT create session TO dbt_XX;
GRANT resource TO dbt_XX;
GRANT create view TO dbt_XX;
GRANT create materialized view TO dbt_XX;
```

```sql
CREATE TABLE dbt_XX.tipo_cliente(
tipo char(1) NOT NULL PRIMARY KEY ,
descricao varchar2(50) NOT NULL
);

INSERT INTO dbt_XX.tipo_cliente(tipo, descricao) VALUES ('V', 'Varejo');
INSERT INTO dbt_XX.tipo_cliente(tipo, descricao) VALUES ('A', 'Atacado');
INSERT INTO dbt_XX.tipo_cliente(tipo, descricao) VALUES ('C', 'Consumidor');

COMMIT;
```

### Acesso ao Oracle

* _Atividade_: Conectar ao Oracle pelo DBeaver

### Download do Projeto de Estudo 
 
* _Atividade_: Descompactar o arquivo em uma pasta `dbt`

### Python (ambiente virtual)

- Arquivos importantes

> - `setup.py` - Configuração de Python por [setuptools](https://realpython.com/pypi-publish-python-package/)
> - `requirements.txt` - Dependencias do dbt
> - `requirements.dev.txt` - Dependencias de desenvolvimento

- Power Shell (Ambiente Microsoft)

```sh
python -m venv venv
.\venv\Scripts/activate.bat
pip install --upgrade pip
pip install -e .[interactive]
```

- Bash (Linux, Mac, WSL)

```sh
python -m venv venv
. venv/bin/activate
pip install --upgrade pip
pip install -e .[interactive]
```

- Make

```sh
make install
```

> *Nota*: Ativar "venv"

## dbt

### Criação de projeto

- Linux: criar pasta `.dbt` no home do usuário

```sh
mkdir ~/.dbt
```

- Windows: criar pasta `.dbt` no home do usuário

```sh
# Obter o caminho da pasta do usuário atual usando variável de ambiente
$userProfile = $env:USERPROFILE

# Definir o nome da pasta a ser criada
$folderName = ".dbt"

# Combinar o caminho do usuário com o nome da pasta para obter o caminho completo
$folderPath = Join-Path -Path $userProfile -ChildPath $folderName

# Criar a pasta se ela não existir
if (-Not (Test-Path -Path $folderPath)) {
    New-Item -ItemType Directory -Path $folderPath
    Write-Output "Pasta '$folderName' criada em '$userProfile' com sucesso."
} else {
    Write-Output "A pasta '$folderName' já existe em '$userProfile'."
}
```

- Criar projeto no dbt

```sh
dbt init <project_name> --profiles-dir=$(shell pwd)/profiles
```

> - project: data_transformation
> - database: [1] oracle
> - protocol: tcp
> - PORT: 1521
> - threads: 1

### Acesso ao Oracle

#### Configurar variáveis de ambiente `.env`

```sh
DBT_ORACLE_HOST=
DBT_ORACLE_USER=dbt_XX
DBT_ORACLE_PASSWORD=senha_XX
DBT_ORACLE_SERVICE=
DBT_ORACLE_SCHEMA=dbt_XX
```

#### Ler o `.env` e carregar as variáveis de ambiente

- Power Shell (Ambiente Microsoft)

```sh
Get-Content .env | ForEach-Object {
    if ($_ -match "^\s*([^=]+)\s*=\s*(.*)\s*$") {
        [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2])
    }
}
```

```sh
dir env:
```

- Bash (Linux, Mac, WSL)

```sh
export $(cat .env | xargs)
```

```sh
env | grep DBT
```

#### Verificar a conexão ao Oracle no dbt

```sh
dbt debug --project-dir data_transformation
```

#### Arquivos de configuração do projeto

> - `profiles.yml` - Configurações de acesso ao BD
> - `dbt_project.yml` - Configurações do projeto

* _Atividade_: Identificar o path dos arquivos
* _Atividade_: Identificar as variáveis de ambiente (Template Jinja)
* _Atividade_: Mover `profiles.yml` para pasta do projeto `data_transformation`

```sh
dbt debug --project-dir data_transformation --profiles-dir data_transformation
```

#### dbt commands (CLI)

- https://docs.getdbt.com/reference/dbt-commands

> *Importante*: Acessar a pasta do projeto `cd data_transformation`

- Aplicar as alterações no Oracle

```sh
dbt run
```
> - *Erro*: Verificar `data_transformation/logs/dbt.log`
> - *Importante*: Verificar `data_transformation/target/run/*`
> - *Nota*: Verificar as tabelas e views criadas no schema

- Debugar 

```sh
dbt run --debug
```

- Testar validações built in

- https://docs.getdbt.com/docs/build/data-tests

```sh
dbt test
```

> *Importante*: Verificar `data_transformation/logs/dbt.log*`

- Compilar o projetos 

```sh
dbt compile
```

> *Importante*: Verificar `data_transformation/target/compiled/*`

- Executar o CLI fora da pasta (usado pelo Airflow) 

```sh
dbt run --project-dir data_transformation --profiles-dir data_transformation
```

- Documentação e Data Lineage

- https://docs.getdbt.com/reference/commands/cmd-docs

```sh
dbt docs generate --profiles-dir data_transformation --project-dir data_transformation
dbt docs serve --profiles-dir data_transformation --project-dir data_transformation
```

> *Navegar*: http://localhost:8080

#### Seeds

Arquivos estáticos

> Pasta: `data_transformation/seeds`

```sh
dbt seed
```

> *Nota*: Verificar as tabelas

* _Atividade_: Criar um arquivo `data_transformation/seeds/raw_clientes.csv` e gerar a tabela no Oracle

```csv
id,nome,uf,tipo_cliente,limite_credito,data_cadastro
1,Marta,SP,V,-1,
2,Pelé,RJ,A,5300,03/05/24
3,Maradona,MG,C,,03/05/2024
4,Messi,MG,,18300
5,Raí,SR,V,,
```

```sh
dbt seed --select raw_clientes
```

> *Importante*: Verificar `data_transformation/target/run/*`

* _Atividade_: Criar um arquivo `data_transformation/seeds/produtos.csv` e gerar a tabela no Oracle
* _Atividade_: Adicionar uma coluna no arquivo `data_transformation/seeds/produtos.csv` e gerar a tabela no Oracle

#### Models/CTE

Tabelas ou views com/sem schemas a partir de [CTE/Common Table Expression](https://www.alura.com.br/artigos/cte-o-que-e-para-que-serve-sql)

```sql
WITH nome_expressão [( nome_colunas [,...n] )]
AS
(CTE_definição_da_consulta)
```

```sql
WITH clientes AS (
	SELECT * FROM RAW_CLIENTES
), ufs AS (
	SELECT * FROM UNIDADES_FEDERACAO 
)
SELECT c.id, c.nome, c.uf, ufs.nome AS estado
FROM clientes c JOIN ufs ufs ON c.UF = ufs.sigla
```

* _Atividade_: Criar `data_transformation/models/dim/dim_clientes.sql` para o CTE acima

```sh
dbt run --select dim_clientes
```

> - *Observação*: Qual objeto foi criado no BD?
> - *Observação*: Como está a documentação?

#### Models/References

Referenciar objetos com uso de `{{ ref("object_name") }}`

- https://docs.getdbt.com/reference/dbt-jinja-functions/ref

* _Atividade_: Alterar `data_transformation/models/dim/dim_clientes.sql`

```sql
WITH clientes AS (
	SELECT * FROM {{ ref("raw_clientes") }}
), ufs AS (
	SELECT * FROM {{ ref("unidades_federacao") }} 
)
SELECT c.id, c.nome, c.uf, ufs.nome AS estado
FROM clientes c LEFT JOIN ufs ufs ON c.UF = ufs.sigla
```

```sh
dbt run --select dim_clientes
```
> - *Observação*: Como está a documentação? (Data Lineage)

#### Models/Sources

Mapear objetos existentes que não foram criados pelo dbt

- https://docs.getdbt.com/docs/build/sources

`data_transformation/models/sources.yml`

```sh
version: 2

sources:
  - name: raw 
    schema: dbt_XX
    tables:
      - name: raw_tipo_cliente
        identifier: tipo_cliente
```

* _Atividade_: Alterar `data_transformation/models/dim/dim_clientes.sql`

```sql
WITH clientes AS (
	SELECT * 
	FROM {{ ref("raw_clientes") }}
), ufs AS (
	SELECT 
		uf.sigla, 
		uf.nome as estado 
	FROM {{ ref("unidades_federacao") }} uf
), tipos_cliente AS (
	SELECT * 
	FROM {{ source ("raw", "raw_tipo_cliente") }}
)
SELECT 
	c.id, 
	c.nome, 
	c.uf, 
	ufs.estado,
	tc.descricao as tipo_cliente
FROM 
	clientes c LEFT JOIN ufs ufs ON c.UF = ufs.sigla
	LEFT JOIN tipos_cliente tc on tc.tipo = c.tipo_cliente
```

```sh
dbt compile --select dim_clientes
```

> - *Importante*: Verificar `data_transformation/target/run/*`

```sh
dbt run --select dim_clientes
```

#### Models/Materializations

- https://docs.getdbt.com/docs/build/materializations

* _Atividade_: Alterar `data_transformation/dbt_project.yml`

```sh
models:
  data_transformation:
    # Config indicated by + and applies to all files under models/example/
    example:
      +materialized: view
    dim:
      +materialized: table
```

```sh
dbt run --select dim_clientes
```

> - *Importante*: Verificar `data_transformation/target/run/*`

#### Models/Materializations/Table

- table -> `create table as`

```sh
{{ config(materialized='table') }}
```

#### Models/Materializations/View

- view -> `create view as`

```sh
{{ config(materialized='view') }}
```

#### Models/Materializations/Incremental

- incremental -> `merge`

```sh
{{ config(materialized='incremental') }}
```

https://docs.getdbt.com/docs/build/incremental-models

![](assets/imgs/incremental_strategy.png)
https://docs.getdbt.com/docs/build/incremental-strategy
- _Não tem o "merge" para Oracle

#### Models/Materializations/Ephemeral

- ephemeral -> `cte`

```sh
{{ config(materialized='ephemeral') }}
```

#### Models/Materializations/Ephemeral

- materialized view

```sh
{{ config(materialized='materialized_view') }}
```

#### Schemas e validações no dbt

* _Atividade_: Criar o schema `data_transformation/models/dim/dim_clientes.yml`

```sh
version: 2

models:
  - name: dim_clientes
    description: Repositório de dados de clientes
    config:
      contract:
        enforced: true
    columns:
      - name: id
        data_type: number
        description: "The primary key for this table"        
      - name: nome
        data_type: varchar2(4000)
        description: "Nome do cliente"        
      - name: uf
        data_type: varchar2(4000)
        description: "Unidade de Federação (sigla)"        
      - name: estado
        data_type: varchar2(4000)
        description: "Unidade de Federação"                
      - name: tipo_cliente
        data_type: varchar2(50)
        description: "Tipo de cliente"  
      - name: coluna_nova_inexistente
        data_type: varchar2(100)
        description: "coluna_nova_inexistente"  		
```
                    
```sh
dbt run --select dim_clientes
```

> *Importante*: Verificar o erro causado pela validação do schema

#### Macros

* _Atividade_: Criar a macro `data_transformation/macros/dash_min_max.sql`

```sql
{% macro dash_min_max(model, column, identifier, min, max) %}
    SELECT 	
    '{{ model }}' AS tabela,
    'min_max' AS criterio,
    '{{ column }}' AS campo,
    'WHERE {{ identifier }} = ''' || {{ identifier }} || '''' AS detalhe
    FROM {{ model }}
    WHERE {{ column }} NOT BETWEEN {{ min }} AND {{ max }}
{% endmacro %}
```

* _Atividade_: Criar a macro `data_transformation/macros/dash_not_null.sql`

```sql
{% macro dash_not_null(model, column, identifier) %}
    SELECT 	
    '{{ model }}' AS tabela,
    'not null' AS criterio,
    '{{ column }}' AS campo,
    'WHERE {{ identifier }} = ''' || {{ identifier }} || '''' AS detalhe
    FROM {{ model }}
    WHERE {{ column }} IS NULL
{% endmacro %}
```

* _Atividade_: Criar a model `data_transformation/models/dq/dash_errors.sql`

```sql
WITH errors AS (
    {{ dash_not_null('RAW_CLIENTES', 'TIPO_CLIENTE', 'ID' ) }}
    UNION ALL
    {{ dash_min_max('RAW_CLIENTES', 'LIMITE_CREDITO', 'ID', 0, 9999999 ) }}
)
SELECT * FROM ERRORS
```

```sh
dbt run --select dash_errors
```
> - *Importante*: Verificar a view ou table criada no Oracle. 
