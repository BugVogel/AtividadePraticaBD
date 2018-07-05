

/*DDL */


CREATE DATABASE Empresa;
USE Empresa;


CREATE TABLE Departamento ( 
	CodDepartamento INT AUTO_INCREMENT, 
	Descricao VARCHAR(100),
	CONSTRAINT PKDepartamento PRIMARY KEY (CodDepartamento)
	
);


CREATE TABLE Funcionario (


	CodFuncionario INT AUTO_INCREMENT,
	Nome VARCHAR(100),
	CodDepartamento INT,
	CONSTRAINT PK_Funcionario PRIMARY KEY(CodFuncionario)
	


);



CREATE TABLE TipoEquipamento(


	CodTipoEquipamento INT AUTO_INCREMENT,
	Descricao VARCHAR(50),
	CONSTRAINT PK_tipoEquipamento PRIMARY KEY(CodTipoEquipamento)




);


CREATE TABLE Equipamento (


	Etiqueta VARCHAR(50),
	Marca VARCHAR(20),
	Descricao VARCHAR(50),
	dataAquisicao DATE,
	CodTipoEquipamento INT,
	CodDepartamento INT,
	CONSTRAINT PK_Equipamento PRIMARY KEY(Etiqueta)
	
	

);


CREATE TABLE Avaria (


	CodAvaria INT AUTO_INCREMENT,
	Descricao VARCHAR(50),
	Data DATE,
	Etiqueta VARCHAR(50),
	CodFuncionario INT,
	CONSTRAINT PK_Avaria PRIMARY KEY(CodAvaria)
	
	


);



CREATE TABLE Intervencao(


	CodIntervencao INT AUTO_INCREMENT,
	Descricao VARCHAR(50),
	Data DATE,
	CodAvaria INT,
	CodFuncionario INT,
	CONSTRAINT PK_Intervencao PRIMARY KEY(CodIntervencao)
	


);




/* adição de chaves estrangeiras */
ALTER TABLE Funcionario ADD CONSTRAINT FK_DepartamentoFuncionario FOREIGN KEY(CodDepartamento) REFERENCES Departamento(CodDepartamento) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE Equipamento ADD CONSTRAINT FK_TipoEquipamento FOREIGN KEY(CodTipoEquipamento) REFERENCES TipoEquipamento(CodTipoEquipamento) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE Equipamento ADD CONSTRAINT FK_DepartamentoEquipamento FOREIGN KEY(CodDepartamento) REFERENCES Departamento(CodDepartamento) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE Avaria ADD CONSTRAINT FK_Etiqueta FOREIGN KEY(Etiqueta) REFERENCES Equipamento(Etiqueta) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE Avaria ADD CONSTRAINT FK_FuncionarioAvaria FOREIGN KEY(CodFuncionario) REFERENCES Funcionario(CodFuncionario) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE Intervencao ADD CONSTRAINT FK_CodAvaria FOREIGN KEY(CodAvaria) REFERENCES Avaria(CodAvaria) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE Intervencao ADD CONSTRAINT FK_FuncionarioIntervencao FOREIGN KEY(CodFuncionario) REFERENCES Funcionario(CodFuncionario) ON DELETE SET NULL ON UPDATE CASCADE;




/* Adicionando NOT NULL em atributo */
ALTER TABLE Funcionario MODIFY Nome VARCHAR(100) NOT NULL;





/*ALTER TABLE Avaria DROP INDEX FK_Etiqueta; 
  ERRO: #1553 - Cannot drop index 'FK_Etiqueta': needed in a foreign key constraint*/

/*ALTER TABLE Avaria ADD CONSTRAINT FK_Etiqueta FOREIGN KEY(Etiqueta) REFERENCES Equipamento(Etiqueta);  
  COMENTADO JÁ QUE A TABELA JA POSSUI A FK
*/

/*CREATE DOMAIN Dom_Sexo AS CHAR(1) CHECK(VALUE= 'F' OR VALUE='f' OR VALUE='M' OR VALUE='m'); 
  NAO FUNCIONA NO MYSQL*/
ALTER TABLE Funcionario ADD COLUMN Sexo CHAR(1);
/*ALTER TABLE Funcionario ALTER COLUMN Sexo TYPE Dom_Sexo; 
  NAO FUNCIONA NO MYSQL*/


/*Apagar tabela com restric */

/* DROP TABLE Departamento RESTRICT;  
   ERRO: #1451 - Não pode apagar uma linha pai: uma restrição de chave estrangeira falhou
*/





/* DML ************************************* */


/* Departamento */
INSERT INTO Departamento (Descricao) VALUES ('Financeiro');
INSERT INTO Departamento (Descricao) VALUES ('Comercial');
INSERT INTO Departamento (Descricao) VALUES ('Informatica');
INSERT INTO Departamento (Descricao) VALUES ('Gerencia');
INSERT INTO Departamento (Descricao) VALUES ('Presidencia');


/* Funcionario */
INSERT INTO Funcionario (Nome,CodDepartamento,Sexo) VALUES ('Ana Souza', 5,'M');
INSERT INTO Funcionario (Nome,CodDepartamento,Sexo) VALUES ('Ricardo Novais', 4,'F');
INSERT INTO Funcionario (Nome,CodDepartamento,Sexo) VALUES ('Ricardo Freitas', 1,'F');
INSERT INTO Funcionario (Nome,CodDepartamento,Sexo) VALUES ('Joao Pedro', 3,'M');
INSERT INTO Funcionario (Nome,CodDepartamento,Sexo) VALUES ('Matheus Rios', 2,'M');
INSERT INTO Funcionario (Nome,CodDepartamento,Sexo) VALUES ('Rivaldo Júnior', 2,'M');

/* TipoEquipamento */

INSERT INTO TipoEquipamento (Descricao) VALUES ('Telefone');
INSERT INTO TipoEquipamento (Descricao) VALUES ('Televisao');
INSERT INTO TipoEquipamento (Descricao) VALUES ('Maquina de Cartao');
INSERT INTO TipoEquipamento (Descricao) VALUES ('Computador');
INSERT INTO TipoEquipamento (Descricao) VALUES ('Impressora');


/* Equipamento */



INSERT INTO Equipamento VALUES ('PC001CTB', 'HP','IMPRESSORA PRETO-BRANCO', '2018-03-05', 4, 1);
INSERT INTO Equipamento VALUES ('PC002CTB', 'HP','IMPRESSORA COLORIDA', '2017-05-21', 2, 5);
INSERT INTO Equipamento VALUES ('PC003CTB', 'HP','IMPRESSORA COLORIDA', '2016-06-10', 5, 4);
INSERT INTO Equipamento VALUES ('PC004CTB', 'HP','IMPRESSORA COLORIDA', '2018-06-15', 3, 3);
INSERT INTO Equipamento VALUES ('PC005CTB', 'HP','IMPRESSORA COLORIDA', '2016-06-16', 5, 2);


/* Avaria */

INSERT INTO Avaria (Descricao,Data, Etiqueta, CodFuncionario) VALUES ('Impressora sem ligar', '2018-06-18 ', 'PC002CTB', 5);
INSERT INTO Avaria (Descricao,Data, Etiqueta, CodFuncionario) VALUES ('Impressora com leitor de cartucho quebrado', '2018-06-20', 'PC002CTB', 3);
INSERT INTO Avaria (Descricao,Data, Etiqueta, CodFuncionario) VALUES ('Impressora sem ligar', '2018-06-25', 'PC003CTB', 2);
INSERT INTO Avaria (Descricao,Data, Etiqueta, CodFuncionario) VALUES ('Impressora sem ligar', '2018-06-27', 'PC005CTB', 2);
INSERT INTO Avaria (Descricao,Data, Etiqueta, CodFuncionario) VALUES ('Impressora sem ligar', '2018-06-27', 'PC004CTB', 4);

/*Intervencao */


INSERT INTO Intervencao (Descricao, Data, CodAvaria, CodFuncionario) VALUES ('Troca de Fonte','2018-06-20', 1, 3);
INSERT INTO Intervencao (Descricao, Data, CodAvaria, CodFuncionario) VALUES ('Troca leitor de cartucho','2018-06-21', 2, 5);
INSERT INTO Intervencao (Descricao, Data, CodAvaria, CodFuncionario) VALUES ('Troca de Fonte','2018-06-26', 3, 2);
INSERT INTO Intervencao (Descricao, Data, CodAvaria, CodFuncionario) VALUES ('Troca de Fonte','2018-06-28', 4, 4);
INSERT INTO Intervencao (Descricao, Data, CodAvaria, CodFuncionario) VALUES ('Troca de Fonte','2018-06-30', 5, 4);



/* Criando copias das tabelas */


CREATE TABLE DepartamentoCopia LIKE Departamento; /*Para copiar os tipos e não dar erro*/
INSERT INTO DepartamentoCopia SELECT*FROM Departamento;
CREATE TABLE FuncionarioCopia LIKE Funcionario;
INSERT INTO FuncionarioCopia SELECT*FROM Funcionario;
CREATE TABLE TipoEquipamentoCopia LIKE TipoEquipamento;
INSERT INTO TipoEquipamentoCopia SELECT*FROM TipoEquipamento;
CREATE TABLE EquipamentoCopia LIKE Equipamento;
INSERT INTO EquipamentoCopia SELECT*FROM Equipamento;
CREATE TABLE AvariaCopia LIKE Avaria;
INSERT INTO AvariaCopia SELECT*FROM Avaria;
CREATE TABLE IntervencaoCopia LIKE Intervencao;
INSERT INTO IntervencaoCopia SELECT*FROM Intervencao;




ALTER TABLE FuncionarioCopia DROP INDEX FK_DepartamentoFuncionario;
ALTER TABLE FuncionarioCopia ADD CONSTRAINT FK_DepartamentoFuncionarioCopia FOREIGN KEY(CodDepartamento) REFERENCES DepartamentoCopia(CodDepartamento) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE EquipamentoCopia DROP INDEX FK_TipoEquipamento;
ALTER TABLE EquipamentoCopia ADD CONSTRAINT FK_TipoEquipamentoCopia FOREIGN KEY(CodTipoEquipamento) REFERENCES TipoEquipamentoCopia(CodTipoEquipamento) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE EquipamentoCopia DROP INDEX FK_DepartamentoEquipamento;
ALTER TABLE EquipamentoCopia ADD CONSTRAINT FK_DepartamentoEquipamentoCopia FOREIGN KEY(CodDepartamento) REFERENCES DepartamentoCopia(CodDepartamento) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE AvariaCopia DROP INDEX FK_Etiqueta;
ALTER TABLE AvariaCopia ADD CONSTRAINT FK_EtiquetaCopia FOREIGN KEY(Etiqueta) REFERENCES EquipamentoCopia(Etiqueta) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE AvariaCopia DROP INDEX FK_FuncionarioAvaria;
ALTER TABLE AvariaCopia ADD CONSTRAINT FK_FuncionarioAvariaCopia FOREIGN KEY(CodFuncionario) REFERENCES FuncionarioCopia(CodFuncionario) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE IntervencaoCopia DROP INDEX FK_CodAvaria;
ALTER TABLE IntervencaoCopia ADD CONSTRAINT FK_CodAvariaCopia FOREIGN KEY(CodAvaria) REFERENCES AvariaCopia(CodAvaria) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE IntervencaoCopia DROP INDEX FK_FuncionarioIntervencao;
ALTER TABLE IntervencaoCopia ADD CONSTRAINT FK_FuncionarioIntervencaoCopia FOREIGN KEY(CodFuncionario) REFERENCES FuncionarioCopia(CodFuncionario) ON DELETE SET NULL ON UPDATE CASCADE;



DELETE FROM FuncionarioCopia;

/* Insere de novo para fazer novas manipulações*/
INSERT INTO FuncionarioCopia (Nome,CodDepartamento,Sexo) VALUES ('Ana Souza', 5,'M');
INSERT INTO FuncionarioCopia (Nome,CodDepartamento,Sexo) VALUES ('Ricardo Novais', 4,'F');
INSERT INTO FuncionarioCopia (Nome,CodDepartamento,Sexo) VALUES ('Ricardo Freitas', 1,'F');
INSERT INTO FuncionarioCopia (Nome,CodDepartamento,Sexo) VALUES ('Joao Pedro', 3,'M');
INSERT INTO FuncionarioCopia (Nome,CodDepartamento,Sexo) VALUES ('Matheus Rios', 2,'M');
INSERT INTO FuncionarioCopia (Nome,CodDepartamento,Sexo) VALUES ('Rivaldo Júnior', 2,'M');

DELETE FROM EquipamentoCopia WHERE CodDepartamento=(SELECT CodDepartamento FROM DepartamentoCopia WHERE Descricao='Informatica' );
UPDATE EquipamentoCopia SET Marca='Samsung';
UPDATE FuncionarioCopia SET CodDepartamento=1 WHERE Nome LIKE 'Ricardo%';
UPDATE FuncionarioCopia SET CodDepartamento=(SELECT CodDepartamento FROM DepartamentoCopia WHERE Descricao='Informatica') WHERE Nome LIKE 'Ricardo%';
SELECT*FROM FuncionarioCopia;
SELECT*FROM FuncionarioCopia WHERE CodDepartamento=(SELECT CodDepartamento FROM DepartamentoCopia WHERE Descricao='Comercial');
SELECT*FROM EquipamentoCopia WHERE CodTipoEquipamento=(SELECT CodTipoEquipamento FROM TipoEquipamentoCopia WHERE Descricao='Computador');
SELECT Nome FROM FuncionarioCopia WHERE CodFuncionario IN (SELECT CodFuncionario FROM AvariaCopia);