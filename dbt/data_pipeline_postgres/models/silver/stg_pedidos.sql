{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

select 
    p.id,
    p.id_cliente,
    p.data_pedido,
    p.valor_total
from {{ source("bronze","src_pedidos") }} p