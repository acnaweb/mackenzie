WITH clientes AS (
    SELECT * FROM {{ ref("raw_clientes")}}
), ufs AS (
    SELECT * FROM {{ source("db_origem", "src_unidades_federacao")}}
)
SELECT c.id, c.nome, c.uf, ufs.nome AS estado
FROM clientes c JOIN ufs ufs ON c.UF = ufs.sigla