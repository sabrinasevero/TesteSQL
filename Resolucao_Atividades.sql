--Atividade a. Consultas Básicas:
--a.1. Lista de funcionários ordenando pelo salário decrescente:

SELECT id_vendedor, nome, cargo, salario
FROM VENDEDORES
ORDER BY salario DESC;

--a.2. Lista de pedidos de vendas ordenado por data de emissão:

SELECT id_pedido, id_empresa, id_cliente, valor_total, data_emissao, situacao
FROM PEDIDO
ORDER BY data_emissao;

--a.3. Valor de faturamento por cliente:

SELECT 
  C.id_cliente,
  C.razao_social,
  SUM(P.valor_total) AS faturamento_total
FROM 
  CLIENTES C
  JOIN PEDIDO P ON C.id_cliente = P.id_cliente
GROUP BY 
  C.id_cliente, C.razao_social;

--a.4. Valor de faturamento por empresa:

SELECT 
  E.id_empresa,
  E.razao_social,
  SUM(P.valor_total) AS faturamento_total
FROM 
  EMPRESA E
  JOIN PEDIDO P ON E.id_empresa = P.id_empresa
GROUP BY 
  E.id_empresa, E.razao_social;

--a.5 Valor de faturamento por vendedor:

SELECT 
  V.id_vendedor,
  V.nome,
  SUM(P.valor_total) AS faturamento_total
FROM 
  VENDEDORES V
  JOIN CLIENTES C ON V.id_vendedor = C.id_vendedor
  JOIN PEDIDO P ON C.id_cliente = P.id_cliente
GROUP BY 
  V.id_vendedor, V.nome;


--Atividade b. Consultas de Junção

--b.1 Unindo a listagem de produtos com a listagem de clientes e formulando o preço base do produto:

SELECT
  PRODUTOS.id_produto,
  PRODUTOS.descricao,
  CLIENTES.id_cliente,
  CLIENTES.razao_social AS cliente_razao_social,
  EMPRESA.id_empresa,
  EMPRESA.razao_social AS empresa_razao_social,
  VENDEDORES.id_vendedor,
  VENDEDORES.nome AS vendedor_nome,
  CONFIG_PRECO_PRODUTO.preco_minimo,
  CONFIG_PRECO_PRODUTO.preco_maximo,
  
  --A função COALESCE está sendo usada para definir o preco_base:

  COALESCE(
    --Se a subconsulta não encontrar nenhum resultado, a função retorna CONFIG_PRECO_PRODUTO.preco_minimo como o preco_base
    (SELECT TOP 1 ITENS_PEDIDO.preco_praticado 
     FROM ITENS_PEDIDO 
     JOIN PEDIDO ON ITENS_PEDIDO.id_pedido = PEDIDO.id_pedido
     WHERE ITENS_PEDIDO.id_produto = PRODUTOS.id_produto AND PEDIDO.id_cliente = CLIENTES.id_cliente
     ORDER BY PEDIDO.data_emissao DESC),
    CONFIG_PRECO_PRODUTO.preco_minimo
  ) AS preco_base
FROM 
  PRODUTOS
  JOIN CONFIG_PRECO_PRODUTO ON PRODUTOS.id_produto = CONFIG_PRECO_PRODUTO.id_produto
  JOIN EMPRESA ON CONFIG_PRECO_PRODUTO.id_empresa = EMPRESA.id_empresa
  JOIN CLIENTES ON EMPRESA.id_empresa = CLIENTES.id_empresa
  JOIN VENDEDORES ON CLIENTES.id_vendedor = VENDEDORES.id_vendedor
ORDER BY 
  PRODUTOS.id_produto, CLIENTES.id_cliente;
