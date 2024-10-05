

CREATE TABLE pedidos (
id numeric,
data_pedido date,
id_cliente numeric,
valor_total decimal
);

create table clientes (
id numeric,
nome varchar(50),
sexo char(1)
);

insert into pedidos values(1, '2024-06-01', 1, 1000);
insert into pedidos values(2, '2024-06-02', 3, 4000);

insert into clientes values(1, 'Pelé', '1');
insert into clientes values(3, 'Madona', '2');
insert into clientes values(5, 'Senna', '1');
