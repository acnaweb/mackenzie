# dbt

## Commands

```
make install
```

```
dbt init demo_oracle
dbt init demo_mysql
dbt init demo_mysql --profiles-dir=$(pwd)/profiles
dbt debug --project-dir=$(pwd)/demo_mysql --profiles-dir=$(pwd)/profiles
dbt seed --project-dir=$(pwd)/demo_mysql --profiles-dir=$(pwd)/profiles

```
