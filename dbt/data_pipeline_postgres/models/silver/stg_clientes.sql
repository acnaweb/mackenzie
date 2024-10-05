
{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}


with clientes as (
    select 
        c.id,
        c.nome,
        c.sexo
    from {{ source("bronze", "src_clientes")}} c
    ),
tipo_sexo as (
    select 
        cast(round(mr.de) as varchar) as de,
        mr.para,
        sexo.descricao
    from {{ source("bronze", "src_mapping_rules")}} mr
        join {{ source("bronze", "src_domain_sexo")}} sexo
        on mr.para = sexo.tipo
            and mr.tipo = 'sexo'
)
select 
    c.id,
    c.nome,
    ts.para as sexo,
    ts.descricao as sexo_descricao
from 
    clientes c join tipo_sexo ts
    on c.sexo = ts.de
