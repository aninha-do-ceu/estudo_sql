-- Codigo Challenge

-- Infos: 
--São quatro entidades representando clientes, operações, itens e categoria
--	Explicacao:

--	Customers(clientes): possui dados de todos os clientes, sejam eles vendedores ou compradores
--		Atributos da entidade: e-mail, nome, sobrenome, sexo, endereço, data de nascimento, dentre outros
--		Adicional: incluí ID para servir como chave primária do cliente para conseguir identificar precisamente o usuário

--	Item: possui dados dos produtos publicados (ativos ou não). Para identificar se está ativo ou não, deve-se consultar seu estado ou pelo campo de end_date

--	Category(categoria): contém descrição dos produtos os associando a uma categoria

--	Order(transações): contém as operações geradas no site. 
--					   contiene las operaciones que fueron efectuadas en lo site. 

-- 1) Listar usuários que fazem aniversário hoje desde que sua quantidade de vendas em janeiro/2020 seja superior a 1500

-- Gera um subselect pegando vendas de cada usuário da junção das tabelas Customer e Order, trazendo sua data de nascimento junto
-- O subselect é nomeado como tb e tratado como uma tabela
-- Ao final, pega apenas os vendedores que cumpram os requisistos do problema
-- Nota: tratei data de aniversário utilizando substring pegando apenas mês e dia no formato YYYY-MM-DD e o mesmo com GETDATE()
-- O convert no GETDATE é para puxar a data de hoje no formato YYYY-MM-DD

SELECT tb.cli_id, 
	   tb.dt_birth, 
	   tb.sales 
from     
  (SELECT orders.cli_id,
		  customers.dt_birth, 
		  count(*) as sales
  FROM 
  orders INNER join customers
  on orders.cli_id = customers.cli_id
  where dt_order like '2020-01%'
  GROUP BY orders.cli_id,dt_birth) as tb
WHERE tb.sales > 1500 AND substring(dt_birth,6,5) like substring(CONVERT(varchar, GETDATE(), 23),6,5)


-- 2) Listar top 5 usuários que mais venderam nos meses de 2020 na categoria celulares
-- Dados para trazer: mes e ano, nome e sobrenome do usuario, quantidade de vendas, quantidade de produtos e total vendido

SELECT * FROM
	(SELECT ROW_NUMBER() OVER(PARTITION BY dt_order order by sales desc) as ranking,
			tb2.*
	FROM
      (SELECT o.cli_id as customer_id,
              cust.name as name,
              cust.last_name as last_name,
              cat.category_prod as category_prod,
              substring(o.dt_order,1,7) as dt_order,
              count(*) as sales, 
              sum(o.qtd_prod) as qtd_prod, 
              sum(o.total_order) as total
      FROM orders o INNER JOIN customers cust -- Tabelas Orders e Customers serão tratadas como tabelas O e Cust, respectivamente
          ON o.cli_id = cust.cli_id
          LEFT JOIN category cat			  -- Tabela Category tratada como cat
          ON o.prod_id = cat.prod_id
      WHERE substring(o.dt_order,1,4) = '2020'
          AND cat.category = 'Celulares'
      GROUP BY o.cli_id,
              cust.name,
              cust.last_name,
			  cat.category_prod,
              substring(o.dt_order,1,7)) tb2
            ) tb3
WHERE ranking < 6


-- 3) Criar nova tabela com estado do produto ao final de cada dia com um identificador único

CREATE TABLE IF NOT EXISTS prod_status(id_unico, prod_id, status, end_date)

INSERT INTO prod_status 
  SELECT concat(prod_id,convert(varchar, GETDATE(), 23)) as id_unico, orders.prod_id, MAX(item.status), MAX(item.end_date)
  FROM orders LEFT JOIN item
      ON orders.prod_id = item.prod_id
  GROUP BY orders.prod_id
