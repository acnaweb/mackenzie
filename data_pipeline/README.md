# Data Pipeline

- ERP - Source (postgres)
	- pedidos
	- clientes	
- List of Values - Source (minio)	
	- sexo
- Data Ingestion (Airbyte)
- Destination (postgres) bronze
- dbt (transformation)
	- mapping
	- uppercase

### Execução

```sh
data_pipeline/scripts/run_airbyte.sh
```

```sh
docker run -d \
	--name postgres \
    -e POSTGRES_USER=new_user \
    -e POSTGRES_PASSWORD=my_pwd \
    -p 5432:5432 \
    postgres
```

- requirements.txt -> Adicionar dependencia dbt-postgres
- Criar projeto dbt data_pipeline_postgres

### Repositórios

- https://github.com/acnaweb/database
- https://github.com/acnaweb/minio
- https://github.com/acnaweb/airbyte

### Datasets

- s3://marketmining-public/domain_sexo.csv
- s3://marketmining-public/mapping_rules.csv

## Referencias

- https://reference.airbyte.com/reference/start
- https://docs.airbyte.com/operator-guides/collecting-metrics


