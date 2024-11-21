-- 1. Encontre os nomes de todos os empregados que trabalham para o departamento de Engenharia Civil --
SELECT nome 
FROM empregado 
WHERE depto = (SELECT numero FROM departamento WHERE nome = 'Engenharia Civil');

-- 2. Para todos os projetos localizados em “São Paulo”, listar os números dos projetos, os números dos departamentos, e o nome do gerente do departamento --
SELECT p.numero AS numero_projeto, d.numero AS numero_departamento, e.nome AS nome_gerente
FROM projeto p
JOIN departamento_projeto dp ON p.numero = dp.numero_projeto
JOIN departamento d ON dp.numero_depto = d.numero
JOIN empregado e ON d.rg_gerente = e.rg
WHERE p.localizacao = 'São Paulo';

-- 3. Encontre os empregados que trabalham em todos os projetos controlados pelo departamento número 3 -- **************
SELECT e.nome
FROM empregado e
WHERE NOT EXISTS (
    SELECT dp.numero_projeto
    FROM departamento_projeto dp
    WHERE dp.numero_depto = 3
    AND dp.numero_projeto NOT IN (
        SELECT ep.numero_projeto
        FROM empregado_projeto ep
        WHERE ep.rg_empregado = e.rg
    )
);

-- 4. Faça uma lista dos números dos projetos que envolvem um empregado chamado “Fernando” como um trabalhador ou como um gerente do departamento que controla o projeto --
SELECT DISTINCT p.numero
FROM projeto p
JOIN departamento_projeto dp ON p.numero = dp.numero_projeto
JOIN departamento d ON dp.numero_depto = d.numero
JOIN empregado e ON e.depto = d.numero OR e.rg = d.rg_gerente
WHERE e.nome = 'Fernando';

-- 5. Liste os nomes dos empregados que não possuem dependentes --
SELECT nome 
FROM empregado 
WHERE rg NOT IN (SELECT rg_responsavel FROM dependentes);

-- 6. Liste os nomes dos gerentes que têm pelo menos um dependente --
SELECT e.nome
FROM empregado e
JOIN departamento d ON e.rg = d.rg_gerente
WHERE e.rg IN (SELECT rg_responsavel FROM dependentes);

-- 7. Selecione o número do departamento que controla projetos localizados em Rio Claro --
SELECT dp.numero_depto
FROM projeto p
JOIN departamento_projeto dp ON p.numero = dp.numero_projeto
WHERE p.localizacao = 'Rio Claro';

-- 8. Selecione o nome e o RG de todos os funcionários que são supervisores --
SELECT DISTINCT e.nome, e.rg
FROM empregado e
WHERE e.rg IN (SELECT rg_supervisor FROM empregado WHERE rg_supervisor IS NOT NULL);

-- 9. Selecione todos os empregados com salário maior ou igual a 2000,00 --
SELECT nome 
FROM empregado 
WHERE salario >= 2000.00;

-- 10. Selecione todos os empregados cujo nome começa com ‘J’ --
SELECT nome 
FROM empregado 
WHERE nome LIKE 'J%';

-- 11. Mostre todos os empregados que têm ‘Luiz’ ou ‘Luis’ no nome --
SELECT nome 
FROM empregado 
WHERE nome LIKE '%Luiz%' OR nome LIKE '%Luis%';

-- 12. Mostre todos os empregados do departamento de ‘Engenharia Civil’ --
SELECT nome 
FROM empregado 
WHERE depto = (SELECT numero FROM departamento WHERE nome = 'Engenharia Civil');

-- 13. Mostre todos os nomes dos departamentos envolvidos com o projeto ‘Motor 3’ --
SELECT d.nome
FROM departamento d
JOIN departamento_projeto dp ON d.numero = dp.numero_depto
WHERE dp.numero_projeto = (SELECT numero FROM projeto WHERE nome = 'Motor 3');

-- 14. Liste o nome dos empregados envolvidos com o projeto ‘Financeiro 1’ --
SELECT e.nome
FROM empregado e
JOIN empregado_projeto ep ON e.rg = ep.rg_empregado
WHERE ep.numero_projeto = (SELECT numero FROM projeto WHERE nome = 'Financeiro 1');

-- 15. Mostre os funcionários cujo supervisor ganha entre 2000 e 2500 --
SELECT e.nome
FROM empregado e
JOIN empregado s ON e.rg_supervisor = s.rg
WHERE s.salario BETWEEN 2000 AND 2500;

-- 16. Liste o nome dos gerentes que têm ao menos um dependente --
SELECT e.nome
FROM empregado e
JOIN departamento d ON e.rg = d.rg_gerente
WHERE e.rg IN (SELECT rg_responsavel FROM dependentes);

-- 17. Atualize o salário de todos os empregados que trabalham no departamento 2 para R$ 3.000,00 --
UPDATE empregado 
SET salario = 3000.00 
WHERE depto = 2;

-- 18. Fazer um comando SQL para ajustar o salário de todos os funcionários da empresa em 10% --
UPDATE empregado 
SET salario = salario * 1.10;

-- 19. Mostre a média salarial dos empregados da empresa --
SELECT AVG(salario) AS media_salarial 
FROM empregado;

-- 20. Mostre os nomes dos empregados (em ordem alfabética) com salário maior que a média --
SELECT nome
FROM empregado
WHERE salario > (SELECT AVG(salario) FROM empregado)
ORDER BY nome;













