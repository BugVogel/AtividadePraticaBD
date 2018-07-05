

/* 1*/
SELECT Departamento.Descricao, ( SELECT COUNT(CodDepartamento ) FROM Funcionario WHERE CodDepartamento = Departamento.CodDepartamento) AS QUANTIDADEFUNCIONARIO FROM Departamento;

/* 2 */
ALTER TABLE Funcionario ADD COLUMN Salario INT;
UPDATE Funcionario SET Salario='2000' WHERE CodDepartamento=(SELECT CodDepartamento FROM Departamento WHERE Descricao="Financeiro"); 
UPDATE Funcionario SET Salario='1000' WHERE CodDepartamento=(SELECT CodDepartamento FROM Departamento WHERE Descricao="Comercial");
UPDATE Funcionario SET Salario='5000' WHERE CodDepartamento=(SELECT CodDepartamento FROM Departamento WHERE Descricao="Informatica");
UPDATE Funcionario SET Salario='6000.' WHERE CodDepartamento=(SELECT CodDepartamento FROM Departamento WHERE Descricao="Gerencia");
UPDATE Funcionario SET Salario='8000' WHERE CodDepartamento=(SELECT CodDepartamento FROM Departamento WHERE Descricao="Presidencia");

/*3 */
SELECT MAX(Salario) AS SALÁRIOMÁXIMO, MIN(Salario) AS SALÁRIOMÍNIMO , SUM(Salario) AS  TOTALSALÁRIO, AVG(Salario) AS  MEDIASALÁRIO FROM Funcionario;

/* 4*/
INSERT INTO Avaria (Descricao,Data,Etiqueta,CodFuncionario)  VALUES ('Impressora sem cabo', '2018-07-01','PC002CTB',1);
INSERT INTO Avaria (Descricao,Data,Etiqueta,CodFuncionario)  VALUES ('Impressora sem bateria', '2018-07-01','PC001CTB',6);
INSERT INTO Avaria (Descricao,Data,Etiqueta,CodFuncionario)  VALUES ('Impressora sem sem cartucho', '2018-07-01','PC004CTB',6);
INSERT INTO Avaria (Descricao,Data,Etiqueta,CodFuncionario)  VALUES ('Impressora sem ligar', '2018-07-01','PC004CTB',1);

/* 5*/
SELECT Funcionario.Nome, (SELECT COUNT(CodFuncionario) FROM Avaria WHERE CodFuncionario = Funcionario.CodFuncionario)AS QUANTIDADEAVARIA FROM Funcionario;

/* 6 */

SELECT Intervencao.CodIntervencao,Intervencao.Descricao AS DescricaoIntervencao,Intervencao.Data AS DataIntervencao, Funcionario.Nome, Avaria.Descricao AS DescricaoAvaria, Avaria.Data AS DataAvaria FROM (Intervencao JOIN Funcionario ON Intervencao.CodFuncionario = Funcionario.CodFuncionario) JOIN Avaria ON Avaria.CodAvaria = Intervencao.CodAvaria;


/* 7  Usamos o MYSQL e a função também funcionou*/

SELECT CodIntervencao, EXTRACT( YEAR FROM Data) as Ano From Intervencao;

/* 8*/
/* 8.1*/
SELECT EXTRACT(YEAR FROM dataAquisicao) AS DataAquisicao, COUNT(EXTRACT(YEAR FROM dataAquisicao) )AS QuantidadeEquipamento FROM Equipamento GROUP BY EXTRACT(YEAR FROM dataAquisicao);
/* 8.2*/
SELECT Tipoequipamento.Descricao, COUNT(Tipoequipamento.CodTipoEquipamento) FROM (Tipoequipamento JOIN Equipamento ON Tipoequipamento.CodTipoEquipamento = Equipamento.CodTipoEquipamento) GROUP BY Tipoequipamento.CodTipoEquipamento;
/*8.3 */
SELECT EXTRACT(YEAR FROM dataAquisicao) AS DataAquisicao, Tipoequipamento.Descricao ,COUNT(EXTRACT(YEAR FROM dataAquisicao) )AS QuantidadeEquipamento FROM Equipamento JOIN Tipoequipamento ON Equipamento.CodTipoEquipamento = Tipoequipamento.CodTipoEquipamento GROUP BY Tipoequipamento.CodTipoEquipamento;

/* 9*/
SELECT Nome From Funcionario WHERE Salario = (SELECT MAX(Salario) FROM Funcionario);

/* 10 */
SELECT*FROM Avaria  WHERE Etiqueta IN (SELECT Etiqueta FROM Equipamento WHERE CodTipoEquipamento IN (SELECT CodTipoEquipamento FROM Tipoequipamento WHERE Descricao ="Computador"));
/* 11*/
SELECT*FROM Funcionario WHERE EXISTS(SELECT*FROM Intervencao WHERE Funcionario.CodFuncionario = Intervencao.CodFuncionario );
/* 12*/
SELECT*FROM Avaria WHERE NOT EXISTS(SELECT*FROM Intervencao WHERE Avaria.CodAvaria = Intervencao.CodAvaria  );
SELECT*FROM Avaria WHERE CodAvaria NOT IN(SELECT CodAvaria FROM Intervencao );
SELECT*FROM Avaria WHERE CodAvaria NOT IN (SELECT Avaria.CodAvaria FROM Avaria JOIN Intervencao ON Avaria.CodAvaria = Intervencao.CodIntervencao);
/* 13*/
SELECT Departamento.Descricao,SUM(Salario) AS TotalSalario FROM Funcionario JOIN Departamento ON Funcionario.CodDepartamento = Departamento.CodDepartamento GROUP BY Departamento.Descricao;
/* 14*/
SELECT Departamento.Descricao, AVG(Salario) AS mediaSalarial FROM Funcionario JOIN Departamento ON Funcionario.CodDepartamento = Departamento.CodDepartamento GROUP BY Departamento.Descricao ORDER BY AVG(Salario) DESC;
/* 15 */
SELECT Nome From Funcionario WHERE Salario > (SELECT SUM(Salario) From Funcionario WHERE CodDepartamento = (SELECT CodDepartamento From Departamento WHERE Descricao = 'Informatica'));
/* 16 */
SELECT*FROM Funcionario CROSS JOIN Departamento;
/* 17 */
SELECT*FROM Funcionario CROSS JOIN Departamento ON Funcionario.CodDepartamento = Departamento.CodDepartamento;
/* 18 */
INSERT INTO Funcionario (Nome,Sexo,Salario) VALUES ('João Menezes','M','1500');
DELETE FROM Funcionario WHERE CodDepartamento =4;
SELECT*FROM Departamento LEFT OUTER JOIN Funcionario ON Departamento.CodDepartamento = Funcionario.CodDepartamento;
SELECT*FROM Departamento RIGHT OUTER JOIN Funcionario;
/* 19 */
SELECT Funcionario.Nome, Departamento.Descricao FROM Funcionario INNER JOIN Departamento ON Funcionario.CodDepartamento = Departamento.CodDepartamento;