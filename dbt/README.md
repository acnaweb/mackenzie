# dbt

## Commands

```sh
make install
```

```sh
dbt init demo_oracle
dbt init demo_mysql
dbt init demo_mysql --profiles-dir=$(pwd)/profiles
dbt debug --project-dir=$(pwd)/demo_mysql --profiles-dir=$(pwd)/profiles
dbt seed --project-dir=$(pwd)/demo_mysql --profiles-dir=$(pwd)/profiles
dbt run --project-dir=$(pwd)/demo_mysql --profiles-dir=$(pwd)/profiles
dbt test --project-dir=$(pwd)/demo_mysql --profiles-dir=$(pwd)/profiles
dbt docs generate --project-dir=$(pwd)/demo_mysql --profiles-dir=$(pwd)/profiles
dbt docs serve --project-dir=$(pwd)/demo_mysql --profiles-dir=$(pwd)/profiles

```

- .env

```
DATABASE_NAME=
DATABASE_PWD=
DATABASE_SCHEMA=
DATABASE_URL=
DATABASE_USER=
```

- Carregar variáveis de ambiente

```sh
export $(cat .env | xargs)
```
