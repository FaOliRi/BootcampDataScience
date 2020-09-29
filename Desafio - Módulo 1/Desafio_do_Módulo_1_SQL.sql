
CREATE TABLE EMPREGADO
	( PNOME VARCHAR(15) NOT NULL,
	MINICIAL CHAR,
	UNOME VARCHAR(15) NOT NULL,
	SSN CHAR(9) NOT NULL,
	DATANASC DATE,
	ENDERECO VARCHAR(30),
	SEXO CHAR,
	SALARIO DECIMAL(10,2),
	SUPERSSN CHAR(9),
	PRIMARY KEY(SSN),
	FOREIGN KEY(SUPERSSN) REFERENCES EMPREGADO(SSN));

CREATE TABLE DEPARTAMENTO (
	DNOME VARCHAR(15) NOT NULL ,
	DNUMERO INT NOT NULL ,
	GERSSN CHAR(9) NULL ,
	GERDATAINICIO DATE,
	PRIMARY KEY (DNUMERO) ,
	UNIQUE (DNOME) ,
	FOREIGN KEY (GERSSN) REFERENCES EMPREGADO(SSN));

ALTER TABLE EMPREGADO
	ADD DNO INTEGER,
	ADD FOREIGN KEY(DNO) REFERENCES DEPARTAMENTO(DNUMERO);

CREATE TABLE DEPTO_LOCALIZACOES (
	DNUMERO INT NOT NULL,
	DLOCALIZACAO VARCHAR(15) NOT NULL,
	PRIMARY KEY (DNUMERO, DLOCALIZACAO) ,
	FOREIGN KEY (DNUMERO) REFERENCES DEPARTAMENTO(DNUMERO));

CREATE TABLE PROJETO (
	PJNOME VARCHAR(15) NOT NULL ,
	PNUMERO INT NOT NULL ,
	PLOCALIZACAO VARCHAR(15),
	DNUM INT NOT NULL ,
	PRIMARY KEY (PNUMERO) , UNIQUE (PJNOME) ,
	FOREIGN KEY (DNUM) REFERENCES DEPARTAMENTO(DNUMERO));

CREATE TABLE TRABALHA_EM (
	ESSN CHAR(9) NOT NULL ,
	PNO INT NOT NULL,
	HORAS DECIMAL(3,1) NOT NULL ,
	PRIMARY KEY (ESSN, PNO) ,
	FOREIGN KEY (ESSN) REFERENCES EMPREGADO(SSN) ,
	FOREIGN KEY (PNO) REFERENCES PROJETO(PNUMERO));

CREATE TABLE DEPENDENTE(
	ESSN CHAR(9) NOT NULL ,
	NOME_DEPENDENTE VARCHAR(15) NOT NULL,
	SEX CHAR,
	DATANASC DATE,
	PARENTESCO VARCHAR(8) ,
	PRIMARY KEY (ESSN, NOME_DEPENDENTE) ,
	FOREIGN KEY (ESSN) REFERENCES EMPREGADO(SSN));

INSERT INTO DEPARTAMENTO VALUES
('Headquarters', 1, NULL, '1971-06-19'),
('Administration', 4, NULL, '1985-01-01'),
('Research', 5, NULL, '1978-05-22'),
('Automation', 7, NULL, '2006-10-05');

INSERT INTO EMPREGADO VALUES
('James', 'E', 'Borg', '888665555', '1927-11-10', 'Stone, Houston, TX', 'M', 55000, NULL, 1),
('Jennifer', 'S', 'Wallace', '987654321', '1931-06-20', 'Berry, Bellaire, TX', 'F', 43000, '888665555', 4),
('John', 'B', 'Smith', '123456789', '1955-01-09', '731 Fondren, Houston, TX', 'M', 30000, '987654321', 5),
('Franklin', 'T', 'Wong', '333445555', '1945-12-08', '638 Voss, Houston, TX', 'M', 40000, '888665555', 5),
('Joyce', 'A', 'English', '453453453', '1962-12-31', '5631 Rice, Houston, TX', 'F', 25000, '333445555', 5),
('Ramesh', 'K', 'Narayan', '666884444', '1952-09-15', 'Fire Oak, Humble, TX', 'M', 38000, '333445555', 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1959-03-29', 'Dallas, Houston, TX', 'M', 25000, '987654321', 4),
('Alicia', 'J', 'Zelaya', '999887777', '1958-06-19', 'Castle, SPring, TX', 'F', 25000, '987654321', 4);

UPDATE DEPARTAMENTO SET GERSSN = '888665555' WHERE DNUMERO = 1;
UPDATE DEPARTAMENTO SET GERSSN = '987654321' WHERE DNUMERO = 4;
UPDATE DEPARTAMENTO SET GERSSN = '333445555' WHERE DNUMERO = 5;
UPDATE DEPARTAMENTO SET GERSSN = '123456789' WHERE DNUMERO = 7;

INSERT INTO DEPENDENTE VALUES
('123456789', 'Alice', 'F', CAST('31-Dec-78' as DATE), 'Daughter'),
('123456789', 'Elizabeth', 'F', CAST('05-May-57' as DATE), 'Spouse'),
('123456789', 'Michael', 'M', CAST('01-Jan-78' as DATE), 'Son'),
('333445555', 'Alice', 'F', CAST('05-Apr-76' as DATE), 'Daughter'),
('333445555', 'Joy', 'F', CAST('03-May-48' as DATE), 'Spouse'),
('333445555', 'Theodore', 'M', CAST('25-Oct-73' as DATE), 'Son'),
('987654321', 'Abner', 'M', CAST('29-Feb-32' as DATE), 'Spouse');

INSERT INTO DEPTO_LOCALIZACOES VALUES
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston');

INSERT INTO PROJETO VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

INSERT INTO TRABALHA_EM VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('333445555', 2, 10),
('333445555', 3, 10),
('333445555', 10, 10),
('333445555', 20, 10),
('453453453', 1, 20),
('453453453', 2, 20),
('666884444', 3, 40),
('888665555', 20, 0),
('987654321', 20, 15),
('987654321', 30, 20),
('987987987', 10, 35),
('987987987', 30, 5),
('999887777', 10, 10),
('999887777', 30, 30);
/*  Média salarial nessa empresa
select AVG(salario) from empregado;
*/
/*Número de empregados do departamento 5 trabalham mais de 10h por semana no projeto chamado "ProductX"
select COUNT(E.pnome) 
	from 
empregado as E JOIN departamento AS D ON E.ssn= D.gerssn 
join projeto as Pro ON D.dnumero= Pro.dnum 
join trabalha_em TE ON Pro.pnumero=TE.pno
	WHERE
    D.dnumero=5 AND
    Pro.pjnome ='ProductX' AND
    TE.horas >= 10
 */
/*Número empregados possuem um dependente com o mesmo primeiro nome que o deles
 select COUNT(E.pnome) FROM empregado E join dependente De on E.ssn= De.essn
 WHERE E.pnome = De.nome_dependente*/
 /* Nomes de todos os empregados que são diretamente supervisionados por Franklin Wong
 select E.pnome 
 from 
 empregado E 
 	where E.superssn = (select E.superssn from empregado E
 							where E.pnome ='Franklin' AND E.unome= 'Wong')*/
/*Pessoa que possui mais tempo de alocação no projeto 'Newbenefits'
SELECT * 
FROM 
empregado E join trabalha_em Te ON E.ssn= Te.essn 
WHERE 
    Te.horas= (SELECT MAX(horas) from trabalha_em Te JOIN projeto pro ON tE.pno= pro.pnumero WHERE pro.pjnome='Newbenefits')*/

/* A soma dos salários de todos os empregados do departamento chamado 'Research'
SELECT SUM(salario) from  departamento D join empregado E ON D.dnumero= E.dno
where D.dnome ='Research' */

/*Nome do departamento com a menor média de salário entre seus funcionários/
select D.dnome, avg(salario) from departamento D join empregado E on D.gerssn = E.ssn GROUP by D.dnome ORDER by 

