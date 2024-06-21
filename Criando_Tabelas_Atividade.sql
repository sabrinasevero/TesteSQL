-- Criação das tabelas e inserção das informações

-- Criando tabela EMPRESA
CREATE TABLE EMPRESA (
  id_empresa INT PRIMARY KEY,
  razao_social VARCHAR(60) NOT NULL,
  inativo BIT NOT NULL
);

-- Inserção de dados na tabela EMPRESA
INSERT INTO EMPRESA (id_empresa, razao_social, inativo)
VALUES 
  (1, 'Disney', 0),
  (2, 'Test', 1),
  (3, 'Marvel', 0);

-- Criando tabela PRODUTOS
CREATE TABLE PRODUTOS (
  id_produto INT PRIMARY KEY,
  descricao VARCHAR(30),
  inativo BIT NOT NULL
);

-- Inserção de dados na tabela PRODUTOS
INSERT INTO PRODUTOS (id_produto, descricao, inativo)
VALUES 
  (50, 'Testing', 0),
  (51, 'Bom produto', 0),
  (52, 'Filme', 0);

-- Criando tabela VENDEDORES
CREATE TABLE VENDEDORES (
  id_vendedor INT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  cargo VARCHAR(100),
  salario DECIMAL(10, 2),
  data_admissao DATE,
  inativo BIT NOT NULL
);

-- Inserção de dados na tabela VENDEDORES
INSERT INTO VENDEDORES (id_vendedor, nome, cargo, salario, data_admissao, inativo)
VALUES 
  (1, 'João', 'Vendedor', 3000.00, '2020-01-15', 0),
  (2, 'Maria', 'Gerente', 5000.00, '2019-03-20', 1),
  (3, 'Carlos', 'Repositor', 2500.00, '2021-05-01', 0);

-- Criando tabela CONFIG_PRECO_PRODUTO
CREATE TABLE CONFIG_PRECO_PRODUTO (
  id_config_preco_produto INT PRIMARY KEY,
  id_vendedor INT NOT NULL,
  id_empresa INT NOT NULL,
  id_produto INT NOT NULL,
  preco_minimo DECIMAL(10, 2) NOT NULL,
  preco_maximo DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (id_vendedor) REFERENCES VENDEDORES(id_vendedor),
  FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa),
  FOREIGN KEY (id_produto) REFERENCES PRODUTOS(id_produto)
);

-- Inserção de dados na tabela CONFIG_PRECO_PRODUTO
INSERT INTO CONFIG_PRECO_PRODUTO (id_config_preco_produto, id_vendedor, id_empresa, id_produto, preco_minimo, preco_maximo)
VALUES 
  (1, 1, 1, 50, 10.00, 20.00),
  (2, 2, 2, 51, 15.00, 25.00),
  (3, 1, 1, 52, 20.00, 30.00);

-- Criando tabela CLIENTES
CREATE TABLE CLIENTES (
  id_cliente INT PRIMARY KEY,
  razao_social VARCHAR(255) NOT NULL,
  data_cadastro DATE NOT NULL,
  id_vendedor INT NOT NULL,
  id_empresa INT NOT NULL,
  inativo BIT NOT NULL,
  FOREIGN KEY (id_vendedor) REFERENCES VENDEDORES(id_vendedor),
  FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa)
);

-- Inserção de dados na tabela CLIENTES
INSERT INTO CLIENTES (id_cliente, razao_social, data_cadastro, id_vendedor, id_empresa, inativo)
VALUES 
  (1, 'Cliente 1', '2023-06-01', 1, 1, 0),
  (2, 'Cliente 2', '2023-06-15', 2, 2, 1),
  (3, 'Cliente 3', '2023-06-20', 1, 2, 1);

-- Criando tabela PEDIDO
CREATE TABLE PEDIDO (
  id_pedido INT PRIMARY KEY,
  id_empresa INT NOT NULL,
  id_cliente INT NOT NULL,
  valor_total DECIMAL(10, 2) NOT NULL,
  data_emissao DATE NOT NULL,
  situacao VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_empresa) REFERENCES EMPRESA(id_empresa),
  FOREIGN KEY (id_cliente) REFERENCES CLIENTES(id_cliente)
);

-- Inserção de dados na tabela PEDIDO
INSERT INTO PEDIDO (id_pedido, id_empresa, id_cliente, valor_total, data_emissao, situacao)
VALUES 
  (1, 1, 1, 100.00, '2023-06-20', 'Em andamento'),
  (2, 2, 2, 150.00, '2023-06-21', 'Concluído');

-- Criando tabela ITENS_PEDIDO
CREATE TABLE ITENS_PEDIDO (
  id_item_pedido INT PRIMARY KEY,
  id_pedido INT NOT NULL,
  id_produto INT NOT NULL,
  preco_praticado DECIMAL(10, 2) NOT NULL,
  quantidade INT NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
  FOREIGN KEY (id_produto) REFERENCES PRODUTOS(id_produto)
);

-- Inserção de dados na tabela ITENS_PEDIDO
INSERT INTO ITENS_PEDIDO (id_item_pedido, id_pedido, id_produto, preco_praticado, quantidade)
VALUES 
  (1, 1, 50, 10.00, 5),
  (2, 2, 51, 15.00, 10),
  (3, 2, 51, 20.00, 2);

-- Consulta dados da tabela ITENS_PEDIDO
SELECT * FROM ITENS_PEDIDO;
GO
