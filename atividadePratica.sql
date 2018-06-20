

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
	Marca VARCHAR(2),
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
ALTER TABLE Equipamento ADD CONSTRAINT FK_TipoEquipamento FOREIGN KEY(CodTipoEquipamento) REFERENCES TipoEquipamento(CodTipoEquipamento);
ALTER TABLE Equipamento ADD CONSTRAINT FK_DepartamentoEquipamento FOREIGN KEY(CodDepartamento) REFERENCES Departamento(CodDepartamento);
ALTER TABLE Avaria ADD CONSTRAINT FK_Etiqueta FOREIGN KEY(Etiqueta) REFERENCES Equipamento(Etiqueta);
ALTER TABLE Avaria ADD CONSTRAINT FK_Funcionatio FOREIGN KEY(CodFuncionario) REFERENCES Funcionario(CodFuncionario);
ALTER TABLE Intervencao ADD CONSTRAINT FK_CodAvaria FOREIGN KEY(CodAvaria) REFERENCES Avaria(CodAvaria);
ALTER TABLE Intervencao ADD CONSTRAINT FK_Funcionario FOREIGN KEY(CodFuncionario) REFERENCES Funcionario(CodFuncionario);




/* Adicionando NOT NULL em atributo */
ALTER TABLE Funcionario MODIFY Nome SET NOT NULL;





ALTER TABLE Avaria DROP CONSTRAINT FK_Etiqueta;
ALTER TABLE Avaria ADD CONSTRAINT FK_Etiqueta FOREIGN KEY(Etiqueta) REFERENCES Equipamento(Etiqueta);

/*CREATE DOMAIN Dom_Sexo AS CHAR(1) CHECK(VALUE= 'F' OR VALUE='f' OR VALUE='M' OR VALUE='m'); */
ALTER TABLE Funcionario ADD COLUMN Sexo CHAR(1);
/*ALTER TABLE Funcionario ALTER COLUMN Sexo TYPE Dom_Sexo; */


/*Apagar tabela com restric */

DROP TABLE Departamento RESTRICT;





/* DML ************************************* */


/* Departamento */
INSERT INTO Departamento VALUES ('Financeiro');
INSERT INTO Departamento VALUES ('Supervisao');
INSERT INTO Departamento VALUES ('Informatica');
INSERT INTO Departamento VALUES ('Gerencia');
INSERT INTO Departamento VALUES ('Presidencia');


/* Funcionario */
INSERT INTO Funcionario VALUES ('Bruno', '4');
INSERT INTO Funcionario VALUES ('Claudia', '3');
INSERT INTO Funcionario VALUES ('Isabelle', '0');
INSERT INTO Funcionario VALUES ('Joao Pedro', '2');
INSERT INTO Funcionario VALUES ('Matheus', '1');


/* TipoEquipamento */

INSERT INTO TipoEquipamento VALUES ('Telefone');
INSERT INTO TipoEquipamento VALUES ('Televisao');
INSERT INTO TipoEquipamento VALUES ('Maquina de Cartao');
INSERT INTO TipoEquipamento VALUES ('Computador');
INSERT INTO TipoEquipamento VALUES ('Impressora');


/* Equipamento */


INSERT INTO Equipamento

INSERT INTO Equipamento VALUES ('PC001CTB', 'Samsung','IMPRESSORA PRETO-BRANCO', '03-05-2018', '4', '0');
INSERT INTO Equipamento VALUES ('PC002CTB', 'Samsung','IMPRESSORA COLORIDA', '21-05-2018', '4', '4');
INSERT INTO Equipamento VALUES ('PC003CTB', 'Samsung','IMPRESSORA COLORIDA', '10-06-2018', '4', '3');
INSERT INTO Equipamento VALUES ('PC004CTB', 'Samsung','IMPRESSORA COLORIDA', '15-06-2018', '4', '2');
INSERT INTO Equipamento VALUES ('PC005CTB', 'Samsung','IMPRESSORA COLORIDA', '16-06-2018', '4', '1');


/* Avaria */

INSERT INTO Avaria VALUES ('Impressora sem ligar', '18-06-2018', 'PC002CTB', '4');
INSERT INTO Avaria VALUES ('Impressora com leitor de cartucho quebrado', '20-06-2018', 'PC002CTB', '2');
INSERT INTO Avaria VALUES ('Impressora sem ligar', '25-06-2018', 'PC003CTB', '1');
INSERT INTO Avaria VALUES ('Impressora sem ligar', '27-06-2018', 'PC005CTB', '1');
INSERT INTO Avaria VALUES ('Impressora sem ligar', '27-06-2018', 'PC004CTB', '3');

/*Intervencao */


INSERT INTO Intervencao VALUES ('Troca de Fonte','20-06-2018', 0, 3);
INSERT INTO Intervencao VALUES ('Troca leitor de cartucho','21-06-2018', 1, 3);
INSERT INTO Intervencao VALUES ('Troca de Fonte','26-06-2018', 2, 3);
INSERT INTO Intervencao VALUES ('Troca de Fonte','28-06-2018', 3, 3);
INSERT INTO Intervencao VALUES ('Troca de Fonte','30-06-2018', 4, 3);



/* Criando copias das tabelas */


CREATE TABLE DepartamentoCopia AS SELECT*FROM Departamento;
CREATE TABLE FuncionarioCopia AS SELECT*FROM Funcionario;
CREATE TABLE TipoEquipamentoCopia AS SELECT*FROM TipoEquipamento;
CREATE TABLE EquipamentoCopia AS SELECT*FROM Equipamento;
CREATE TABLE AvariaCopia AS SELECT*FROM Avaria;
CREATE TABLE IntervencaoCopia AS SELECT*FROM Intervencao;







/* Adicao de chaves estrangeiras para copias */

ALTER TABLE FuncionarioCopia ADD CONSTRAINT FK_Departamento FOREIGN KEY(CodDepartamento) REFERENCES DepartamentoCopia(CodDepartamento) ON DELETE CASCADE;
ALTER TABLE EquipamentoCopia ADD CONSTRAINT FK_TipoEquipamento FOREIGN KEY(CodTipoEquipamento) REFERENCES TipoEquipamentoCopia(CodTipoEquipamento);
ALTER TABLE EquipamentoCopia ADD CONSTRAINT FK_Departamento FOREIGN KEY (CodDepartamento) REFERENCES DepartamentoCopia(CodDepartamento);
ALTER TABLE AvariaCopia ADD CONSTRAINT FK_Etiqueta FOREIGN KEY(Etiqueta) REFERENCES EquipamentoCopia(Etiqueta);
ALTER TABLE AvariaCopia ADD CONSTRAINT FK_Funcionatio FOREIGN KEY(CodFuncionario) REFERENCES FuncionarioCopia(CodFuncionario);
ALTER TABLE IntervencaoCopia ADD CONSTRAINT FK_CodAvaria FOREIGN KEY(CodAvaria) REFERENCES AvariaCopia(CodAvaria);
ALTER TABLE IntervencaoCopia ADD CONSTRAINT FK_Funcionario FOREIGN KEY(CodFuncionario) REFERENCES FuncionarioCopia(CodFuncionario);








