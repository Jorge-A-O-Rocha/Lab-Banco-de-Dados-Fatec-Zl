create database predioEscola;
use predioEscola;

create table Depto(
	CodDepto char(5),
    NomeDepto varchar(40)
);

alter table Depto
add constraint
primary key
	(CodDepto);

create table Predio(
	CodPred int4,
    NomePredi varchar(40)
);

alter table Predio
add constraint
primary key
	(CodPred);

create table Titulacao(
	CodTit int4,
    NomeTit varchar(40)
);

alter table Titulacao
add constraint
primary key
	(CodTit);

create table Disciplina(
	NumDisc int4,
    CodDepto char(5),
    NomeDisc varchar(10),
    CreditoDisc int4
);

alter table Disciplina
add constraint
primary key
	(NumDisc);

alter table Disciplina
add constraint 
	FK_DISCIPLINA_RELATION_DEPTO 
foreign key
	(CodDepto)  
references 
	Depto(CodDepto) ;
    
create table Professor(
	CodProf int4,
    CodDepto char(5),
    CodTit int4,
    NomeProf varchar(40)
);

alter table Professor
add constraint
primary key
	(CodProf);

alter table Professor
add constraint 
	FK_PROFESSOR_RELATION_DEPTO 
foreign key
	(CodDepto)  
references 
	Depto(CodDepto), 
add constraint 
	FK_PROFESSOR_RELATION_TITULACAO 
foreign key
	(CodTit)  
references 
	Titulacao(CodTit);

create table Sala(
	CodPred int4,
    NumSala int4,
    DescricaoSala varchar(40),
    CapacSala int4
);

alter table Sala
add constraint
primary key
	(NumSala);
    
alter table Sala
add constraint 
	FK_SALA_RELATION_PREDIO 
foreign key
	(CodPred)  
references 
	Predio(CodPred);
    
create table Turma(
	AnoSem int4,
    CodDepto char(5),
    NumDisc int4,
    SiglaTur char(2),
    CapacTur int4
);

alter table Turma
add constraint
primary key
	(AnoSem, SiglaTur,NumDisc,CodDepto);

alter table Turma
add constraint 
	FK_Turma_RELATION_DISCIPLI
foreign key
	(NumDisc)  
references 
	Disciplina(NumDisc), 
add constraint 
	FK_TURMA_RELATION_DEPTO 
foreign key
	(CodDepto)  
references 
	Depto(CodDepto);

create table ProfTurma(
	AnoSem int4,
    CodDepto char(5),
    NumDisc int4,
    SiglaTur char(2),
    CodProf int4
);

alter table ProfTurma
add constraint 
	FK_PROFTURM_PROFTURMA_TURMA
foreign key
	(AnoSem)  
references 
	Turma(AnoSem);

alter table ProfTurma
add constraint  foreign key
	(CodDepto)  
references 
	Turma(CodDepto);
    
alter table ProfTurma
add constraint   foreign key
	(NumDisc)  
references 
	Turma(NumDisc);

CREATE INDEX idx_turma ON Turma ( SiglaTur);

alter table ProfTurma
add constraint FK
foreign key
	(SiglaTur)  
references 
	Turma(SiglaTur);

alter table ProfTurma
add constraint 
	FK_PROFTURM_PROFTURMA_PROFESSOR
foreign key
	(CodProf)
references
	Professor(CodProf);

create  table Horario(
	AnoSem int4,
    CodDepto char(5),
    NumDisc int4,
    SiglaTur char(2),
    DiaSem int4,
    HoraInicio int4,
    NumSala int4,
    CodPred int4,
    NumHoras int4
    );
    
CREATE INDEX id_turma ON Turma (AnoSem, CodDepto, NumDisc, SiglaTur);
alter table Horario
add constraint
foreign key
	(AnoSem,CodDepto,NumDisc,SiglaTur)
references
	Turma(AnoSem,CodDepto,NumDisc,SiglaTur);

alter table Horario
add constraint foreign key
	(CodPred,NumSala)
references
	Sala(CodPred,NumSala);

alter table Horario
add constraint
primary key
	(AnoSem,CodDepto,NumDisc,SiglaTur,DiaSem,HoraInicio);

create table PreReq(
	CodDeptoPreReq char(5),
    NumDiscPreReq int4,
    CodDepto char(5),
    NumDisc int4
);
    
alter table PreReq add constraint FK_PreReq_Disciplina
foreign key (CodDepto, NumDisc) references Disciplina (CodDepto, NumDisc);
 
alter table PreReq add constraint FK_PreReq_Disciplina1
foreign key (CodDeptoPreReq, NumDiscPreReq) references Disciplina (CodDepto, NumDisc);
 
alter table PreReq add constraint PK_PreReq
primary key(CodDepto, NumDisc, CodDeptoPreReq, NumDiscPreReq);


-- inserts  para testar -------------------------------------------------------------------------------------------

-- Inserir dados na tabela Depto
INSERT INTO Depto (CodDepto, NomeDepto) VALUES 
('INF01', 'Departamento de Informática'),
('MAT01', 'Departamento de Matemática'),
('ADM01', 'Departamento de Administração');

-- Inserir dados na tabela Predio
INSERT INTO Predio (CodPred, NomePredi) VALUES 
(43423, 'Informática - aulas'),
(54321, 'Prédio da Matemática');

-- Inserir dados na tabela Titulacao
INSERT INTO Titulacao (CodTit, NomeTit) VALUES 
(1, 'Graduado'),
(2, 'Mestre'),
(3, 'Doutor');

-- Inserir dados na tabela Disciplina
INSERT INTO Disciplina (NumDisc, CodDepto, NomeDisc, CreditoDisc) VALUES 
(1, 'INF01', 'Programa', 4),
(2, 'MAT01', 'Cálculo I', 5),
(3, 'ADM01', 'finança', 3);

INSERT INTO Disciplina (NumDisc, CodDepto, NomeDisc, CreditoDisc) VALUES 
(4, 'INF01', 'Banco sql', 4);

INSERT INTO PreReq (CodDeptoPreReq, NumDiscPreReq, CodDepto, NumDisc) VALUES 
('INF01', 1, 'INF01', 4), 
('MAT01', 2, 'ADM01', 3);

INSERT INTO Disciplina (NumDisc, CodDepto, NomeDisc, CreditoDisc) VALUES 
(5, 'INF01', 'Estrutura ', 4),
(6, 'MAT01', 'Álgebra', 5);
-- Inserir dados na tabela Professor
INSERT INTO Professor (CodProf, CodDepto, CodTit, NomeProf) VALUES 
(101, 'INF01', 3, 'Antunes'),
(102, 'MAT01', 2, 'Martins'),
(103, 'ADM01', 3, 'Silva');

INSERT INTO Professor (CodProf, CodDepto, CodTit, NomeProf) VALUES 
(104, 'INF01', 3, 'Santos');

INSERT INTO Professor (CodProf, CodDepto, CodTit, NomeProf) VALUES 
(105, 'ADM01', 3, 'Souza');

-- Inserir dados na tabela Sala
INSERT INTO Sala (CodPred, NumSala, DescricaoSala, CapacSala) VALUES 
(43423, 101, 'Sala de Aula 101', 50),
(54321, 201, 'Sala de Aula 201', 40);

-- Inserir dados na tabela Turma
INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES 
(20021, 'INF01', 1, 'T1', 30),
(20021, 'MAT01', 2, 'T1', 25),
(20021, 'ADM01', 3, 'T1', 35);

INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES 
(20021, 'INF01', 4, 'T1', 30),
(20021, 'INF01', 4, 'T2', 25);

INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES 
(20021, 'INF01', 5, 'T1', 30),
(20021, 'MAT01', 6, 'T1', 25);


INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES 
(20021, 'INF01', 1, 'T2', 20);

INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES 
(20022, 'INF01', 1, 'T1', 30),
(20022, 'ADM01', 3, 'T1', 35);

INSERT INTO Turma (AnoSem, CodDepto, NumDisc, SiglaTur, CapacTur) VALUES 
(20021, 'ADM01', 3, 'T2', 25);

-- Inserir dados na tabela ProfTurma 
INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES 
(20021, 'INF01', 1, 'T1', 101),
(20021, 'MAT01', 2, 'T1', 102),
(20021, 'ADM01', 3, 'T1', 103);

INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES 
(20021, 'INF01', 4, 'T1', 101),
(20021, 'INF01', 4, 'T2', 104);



INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES 
(20022, 'INF01', 1, 'T1', 104),
(20022, 'ADM01', 3, 'T1', 105);

INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES 
(20021, 'INF01', 1, 'T2', 101);

INSERT INTO ProfTurma (AnoSem, CodDepto, NumDisc, SiglaTur, CodProf) VALUES 
(20021, 'ADM01', 3, 'T2', 101);

-- Inserir dados na tabela Horario  
INSERT INTO Horario (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio, NumSala, CodPred, NumHoras) VALUES 
(20021, 'INF01', 1, 'T1', 2, 8, 101, 43423, 2),
(20021, 'MAT01', 2, 'T1', 4, 10, 201, 54321, 3),
(20021, 'ADM01', 3, 'T1', 3, 9, 201, 54321, 2);

INSERT INTO Horario (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio, NumSala, CodPred, NumHoras) VALUES 
(20021, 'INF01', 4, 'T1', 2, 10, 101, 43423, 2),
(20021, 'INF01', 4, 'T2', 2, 10, 101, 43423, 2);

INSERT INTO Horario (AnoSem, CodDepto, NumDisc, SiglaTur, DiaSem, HoraInicio, NumSala, CodPred, NumHoras) VALUES 
(20021, 'INF01', 1, 'T2', 2, 8, 101, 43423, 2),
(20021, 'ADM01', 3, 'T2', 2, 8, 201, 54321, 2);

-- Inserir dados na tabela PreReq
INSERT INTO PreReq (CodDeptoPreReq, NumDiscPreReq, CodDepto, NumDisc) VALUES 
('MAT01', 2, 'INF01', 1),
('ADM01', 3, 'MAT01', 2);

INSERT INTO PreReq (CodDeptoPreReq, NumDiscPreReq, CodDepto, NumDisc) VALUES 
('ADM01', 3, 'INF01', 1);
-- -----------------------------------------------------------------------------------------------------------------

-- 0 Criar Procedure , usando cursor explicito, para Selecionar a quantidade de disciplinas agrupadas por Departamento.
DELIMITER //
CREATE PROCEDURE QuantidadeDisciplinasPorDepartamento()
BEGIN
    DECLARE NomeDeptoVar VARCHAR(40);
    DECLARE QuantidadeDisciplinas INT;
    DECLARE done INT DEFAULT FALSE; -- Declara a variável para verificar se não há mais resultados
    
    DECLARE cur_results CURSOR FOR
        SELECT d.NomeDepto, COUNT(*) AS QuantidadeDisciplinas
        FROM Disciplina dis
        JOIN Depto d ON dis.CodDepto = d.CodDepto
        GROUP BY d.NomeDepto;
    
    OPEN cur_results;
    
    results_loop: LOOP
        FETCH cur_results INTO NomeDeptoVar, QuantidadeDisciplinas;

        IF done THEN
            LEAVE results_loop;
        END IF;
        SELECT NomeDeptoVar AS NomeDepto, QuantidadeDisciplinas AS QuantidadeDisciplinas;
    END LOOP;
    CLOSE cur_results;
END//
DELIMITER ;
call QuantidadeDisciplinasPorDepartamento10();

-- 1 Obter os códigos dos diferentes departamentos que tem turmas no ano-semestre 2002/1  
DELIMITER **  
CREATE procedure CodDepto20021()
BEGIN
	declare feito int default false;
	declare codDeptos char (5);
	declare disciplinas int;
	declare curs_Depto cursor for select codDepto from turma;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
         OPEN curs_Depto;
         read_loop : LOOP
			 FETCH curs_Depto INTO codDeptos;
		 IF feito THEN
            LEAVE read_loop;
        END IF;
         SELECT distinct(codDepto) from turma where anoSem = 20021;
		END LOOP;
        CLOSE curs_Depto;
	END**
CALL CodDepto20021();

-- 2 Obter os códigos dos professores que são do departamento de código 'INF01' e que ministraram ao menos uma turma em 2002/1.  
DELIMITER !!
create procedure codigoProfINF010()
begin
declare feito int default false;
declare codProfs int;
declare curs_Prof cursor for select codProf from professor;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET feito = TRUE;
        OPEN curs_Prof;
         read_loop : LOOP
			 FETCH curs_Prof INTO codProfs;
		 IF feito THEN
            LEAVE read_loop;
        END IF;
        select distinct(codProf), codDepto from profTurma where codDepto = "INF01" and anosem = 20021; 
	END LOOP;
    CLOSE curs_Prof;
END !!
DELIMITER ;
 
call codigoProfINF010();

-- 3  Obter os horários de aula (dia da semana,hora inicial e número de horas ministradas) do professor "Antunes" em 20021.  
DELIMITER $$
CREATE PROCEDURE horarioAntunes()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE diaSem INT;
    DECLARE horaInicio INT;
    DECLARE numHoras INT;
    DECLARE cur_horarios CURSOR FOR
        SELECT h.DiaSem, h.HoraInicio, h.NumHoras
        FROM Horario h
        INNER JOIN ProfTurma pt ON h.AnoSem = pt.AnoSem
            AND h.CodDepto = pt.CodDepto
            AND h.NumDisc = pt.NumDisc
            AND h.SiglaTur = pt.SiglaTur
        INNER JOIN Professor p ON pt.CodProf = p.CodProf
        WHERE p.NomeProf = 'Antunes'
            AND h.AnoSem = 20021;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur_horarios;
    read_loop: LOOP
        FETCH cur_horarios INTO diaSem, horaInicio, numHoras;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT('Dia da Semana: ', diaSem, ', Hora de Início: ', horaInicio, ', Número de Horas: ', numHoras) AS HorarioAula;

    END LOOP;
    CLOSE cur_horarios;
END$$
DELIMITER ;

call horarioAntunes();

--  4 Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na sala 101 do prédio denominado 'Informática - aulas'.     
DELIMITER ++
CREATE PROCEDURE DepartamentosComAulasNaSala101()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE depto_nome VARCHAR(40);
    DECLARE cur_departamentos CURSOR FOR
        SELECT DISTINCT d.NomeDepto
        FROM Turma t
        INNER JOIN Horario h ON t.AnoSem = h.AnoSem
            AND t.CodDepto = h.CodDepto
            AND t.NumDisc = h.NumDisc
            AND t.SiglaTur = h.SiglaTur
        INNER JOIN Sala s ON h.CodPred = s.CodPred
            AND h.NumSala = s.NumSala
        INNER JOIN Predio p ON s.CodPred = p.CodPred
        INNER JOIN Depto d ON t.CodDepto = d.CodDepto
        WHERE p.NomePredi = 'Informática - aulas'
            AND s.NumSala = 101
            AND t.AnoSem = 20021;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur_departamentos;

    read_loop: LOOP
        FETCH cur_departamentos INTO depto_nome;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT CONCAT('Departamento: ', depto_nome) AS Resultado;
    END LOOP;
    CLOSE cur_departamentos;
END ++
DELIMITER ;

call DepartamentosComAulasNaSala101();
 
-- 5 Obter os códigos dos professores com título denominado 'Doutor' que não ministraram aulas em 2002/1. 
DELIMITER ..
CREATE PROCEDURE codProfNot20021v()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cod_Prof int;
    DECLARE cur_prof CURSOR FOR
        SELECT CodProf
		FROM Professor
		WHERE CodTit = (SELECT CodTit FROM Titulacao WHERE NomeTit = 'Doutor')
		AND CodProf NOT IN (
			SELECT DISTINCT CodProf
			FROM ProfTurma
			WHERE AnoSem = 20021
		);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur_prof;

    read_loop: LOOP
        FETCH cur_prof INTO cod_Prof;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT  cod_Prof AS CodigoProfessor;
    END LOOP;
    CLOSE cur_prof;
END ..
DELIMITER ;

call codProfNot20021v();
 
-- 6 Obter os identificadores das salas (código do prédio e número da sala) que, em 2002/1:  
-- nas segundas-feiras (dia da semana = 2), tiveram ao menos uma turma do departamento 'Informática', e  
-- nas quartas-feiras (dia da semana = 4), tiveram ao menos uma turma ministrada pelo professor denominado 'Antunes'.
DELIMITER >>
CREATE PROCEDURE predioSala2e4InfoAntunes()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cod_Pred int;
    DECLARE num_Sala int;
    DECLARE cur_pred CURSOR FOR
       SELECT DISTINCT h.CodPred, h.NumSala
		FROM Horario h
		JOIN Turma t ON h.AnoSem = t.AnoSem AND h.CodDepto = t.CodDepto AND h.NumDisc = t.NumDisc AND h.SiglaTur = t.SiglaTur
		JOIN Professor p ON t.CodDepto = p.CodDepto
		WHERE (h.DiaSem = 2 AND t.CodDepto = 'INF01')
		or (h.DiaSem = 4 AND p.NomeProf = 'Antunes');

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur_pred;

    read_loop: LOOP
        FETCH cur_pred INTO cod_Pred, num_Sala;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT  cod_Pred, num_Sala;
    END LOOP;
    CLOSE cur_pred;
END >>
DELIMITER ;

call predioSala2e4InfoAntunes();
  
-- 7  Obter o dia da semana, a hora de início e o número de horas de cada horário de cada turma ministrada por um professor de nome `Antunes', em 2002/1, na sala número 101 do prédio de código 43423.  
DELIMITER <<
CREATE PROCEDURE HorarioAntunesSala101()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE diaSem INT;
    DECLARE horaInicio INT;
    DECLARE numHoras INT;
    DECLARE cur_horarios CURSOR FOR
        SELECT h.DiaSem, h.HoraInicio, h.NumHoras
        FROM Horario h
        INNER JOIN ProfTurma pt ON h.AnoSem = pt.AnoSem
            AND h.CodDepto = pt.CodDepto
            AND h.NumDisc = pt.NumDisc
            AND h.SiglaTur = pt.SiglaTur
        INNER JOIN Professor p ON pt.CodProf = p.CodProf
        INNER JOIN Sala s ON h.CodPred = s.CodPred
            AND h.NumSala = s.NumSala
        INNER JOIN Predio pr ON s.CodPred = pr.CodPred
        WHERE p.NomeProf = 'Antunes'
            AND h.AnoSem = 20021
            AND s.NumSala = 101
            AND pr.CodPred = 43423;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur_horarios;
    read_loop: LOOP
        FETCH cur_horarios INTO diaSem, horaInicio, numHoras;

        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT('Dia da Semana: ', diaSem, ', Hora de Início: ', horaInicio, ', Número de Horas: ', numHoras) AS HorarioAula;

    END LOOP;
    CLOSE cur_horarios;
END<<
DELIMITER ;

call HorarioAntunesSala101();

-- 8 Um professor pode ministrar turmas de disciplinas pertencentes a outros departamentos.
-- Para cada professor que já ministrou aulas em disciplinas de outros departamentos, 
-- obter o código do professor, seu nome, o nome de seu departamento e o 
-- nome do departamento no qual ministrou disciplina. 
DELIMITER ::
CREATE PROCEDURE profDeptoMinistrado()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cod_prof INT;
    DECLARE nome_prof varchar(40);
    DECLARE nome_depto varchar(40);
    DECLARE depto_atual VARCHAR(40);
    DECLARE depto_ministrado VARCHAR(40);
    DECLARE cur_ProfMinistrado CURSOR FOR
        SELECT DISTINCT p.CodProf, p.NomeProf, d1.NomeDepto AS DepartamentoAtual,
        d2.NomeDepto AS DepartamentoMinistrado
		FROM Professor p
		INNER JOIN ProfTurma pt ON p.CodProf = pt.CodProf
		INNER JOIN Disciplina dis ON pt.CodDepto = dis.CodDepto
		INNER JOIN Depto d1 ON p.CodDepto = d1.CodDepto
		INNER JOIN Depto d2 ON dis.CodDepto = d2.CodDepto
		WHERE p.CodDepto != dis.CodDepto;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur_ProfMinistrado;
    read_loop: LOOP
                FETCH cur_ProfMinistrado INTO cod_prof, nome_prof, depto_atual, depto_ministrado;
                
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT cod_prof, nome_prof, depto_atual, depto_ministrado;

    END LOOP;
    CLOSE cur_ProfMinistrado;
END ::
DELIMITER ;

call profDeptoMinistrado();

-- 9 Obter o nome dos professores que possuem horários conflitantes (possuem turmas que tenham a mesma hora inicial, no mesmo dia da semana e no mesmo semestre). Além dos nomes, mostrar as chaves primárias das turmas em conflito.  
DELIMITER ||
CREATE PROCEDURE GetProfessorTurmaPairs()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE professor_name VARCHAR(100);
    DECLARE chave_turma1 VARCHAR(100);
    DECLARE chave_turma2 VARCHAR(100);
    
    DECLARE cur CURSOR FOR
        SELECT DISTINCT p.NomeProf, 
                        CONCAT(t1.AnoSem, '-', t1.CodDepto, '-', t1.NumDisc, '-', t1.SiglaTur) AS ChaveTurma1,
                        CONCAT(t2.AnoSem, '-', t2.CodDepto, '-', t2.NumDisc, '-', t2.SiglaTur) AS ChaveTurma2
        FROM Professor p
        INNER JOIN ProfTurma pt1 ON p.CodProf = pt1.CodProf
        INNER JOIN Horario h1 ON pt1.AnoSem = h1.AnoSem
                                AND pt1.CodDepto = h1.CodDepto
                                AND pt1.NumDisc = h1.NumDisc
                                AND pt1.SiglaTur = h1.SiglaTur
        INNER JOIN Turma t1 ON pt1.AnoSem = t1.AnoSem
                            AND pt1.CodDepto = t1.CodDepto
                            AND pt1.NumDisc = t1.NumDisc
                            AND pt1.SiglaTur = t1.SiglaTur
        INNER JOIN ProfTurma pt2 ON p.CodProf = pt2.CodProf
        INNER JOIN Horario h2 ON pt2.AnoSem = h2.AnoSem
                                AND pt2.CodDepto = h2.CodDepto
                                AND pt2.NumDisc = h2.NumDisc
                                AND pt2.SiglaTur = h2.SiglaTur
                                AND h1.DiaSem = h2.DiaSem
                                AND h1.HoraInicio = h2.HoraInicio
        INNER JOIN Turma t2 ON pt2.AnoSem = t2.AnoSem
                            AND pt2.CodDepto = t2.CodDepto
                            AND pt2.NumDisc = t2.NumDisc
                            AND pt2.SiglaTur = t2.SiglaTur
                            AND t1.AnoSem = t2.AnoSem
                            AND t1.CodDepto = t2.CodDepto
                            AND t1.NumDisc = t2.NumDisc
                            AND t1.SiglaTur != t2.SiglaTur;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO professor_name, chave_turma1, chave_turma2;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT professor_name, chave_turma1, chave_turma2;
    END LOOP;
    
    CLOSE cur;
END||

DELIMITER ;

call GetProfessorTurmaPairs();

-- 10 Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu pré-requisito.  
DELIMITER ¨¨
CREATE PROCEDURE ListarPreRequisitosv()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE disciplina_nome VARCHAR(10);
    DECLARE pre_requisito_nome VARCHAR(10);
    DECLARE cur CURSOR FOR
        SELECT D1.NomeDisc AS Disciplina, D2.NomeDisc AS PreRequisito
        FROM Disciplina D1
        INNER JOIN PreReq P ON D1.CodDepto = P.CodDepto AND D1.NumDisc = P.NumDisc
        INNER JOIN Disciplina D2 ON P.CodDeptoPreReq = D2.CodDepto AND P.NumDiscPreReq = D2.NumDisc;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO disciplina_nome, pre_requisito_nome;

        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT disciplina_nome, pre_requisito_nome;
        
    END LOOP;
    CLOSE cur;
    
END¨¨
DELIMITER ;

call ListarPreRequisitosv();

-- 11 Obter os nomes das disciplinas que não têm pré-requisito.  
DELIMITER %%

CREATE PROCEDURE ListarDisciplinasSemPreRequisito()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE disciplina_nome VARCHAR(10);
    DECLARE cur CURSOR FOR
        SELECT D.NomeDisc
        FROM Disciplina D
        LEFT JOIN PreReq P ON D.CodDepto = P.CodDeptoPreReq AND D.NumDisc = P.NumDiscPreReq
        WHERE P.CodDeptoPreReq IS NULL AND P.NumDiscPreReq IS NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO disciplina_nome;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT disciplina_nome;
        
    END LOOP;
    CLOSE cur;
    
END%%
DELIMITER ;

call ListarDisciplinasSemPreRequisito();

-- 12 Obter o nome de cada disciplina que possui ao menos dois pré-requisitos.  

DELIMITER ££
CREATE PROCEDURE DisciplinasComDoisPreRequisitos()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE disciplina VARCHAR(10);
    
    DECLARE cur CURSOR FOR 
        SELECT D.NomeDisc
        FROM Disciplina D
        INNER JOIN (
            SELECT CodDepto, NumDisc
            FROM PreReq
            GROUP BY CodDepto, NumDisc
            HAVING COUNT(*) >= 2
        ) AS DisciplinasComDoisPreRequisitos ON D.CodDepto = DisciplinasComDoisPreRequisitos.CodDepto 
                                             AND D.NumDisc = DisciplinasComDoisPreRequisitos.NumDisc;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    SET disciplina = '';

    read_loop: LOOP
        FETCH cur INTO disciplina;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT disciplina AS 'Disciplina Com Dois Pré-Requisitos';
    END LOOP;
    CLOSE cur;
END ££

DELIMITER ;

call  DisciplinasComDoisPreRequisitos();

