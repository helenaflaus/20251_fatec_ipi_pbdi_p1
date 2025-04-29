-- Active: 1742297523462@@127.0.0.1@5432@20251_fatec_pbdi_P1
-- ----------------------------------------------------------------
-- 1 Base de dados e criação de tabela
--escreva a sua solução aqui
CREATE TABLE tb_students_performance (
    STUDENTID VARCHAR(200),
    GRADE INT,
    MOTHER_EDU INT,
    FATHER_EDU INT,
    PREP_STUDY INT,
    SALARY INT,
    PREP_EXAM INT
);

-- ----------------------------------------------------------------
-- 2 Resultado em função da formação dos pais
--escreva a sua solução aqui

 
-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui



-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui
DO $$
DECLARE
   -- 1. Declaração cursor vinculado
   cur_AlunoFreq CURSOR FOR 
   SELECT SALARY, PREP_EXAM FROM tb_students_performance
   WHERE (SALARY = 5) AND (PREP_EXAM = 2);
   v_qtdalunos INT;
BEGIN
  -- 2. Abertura do cursor
  OPEN cur_AlunoFreq;
  FETCH cur_AlunoFreq INTO v_qtdalunos;
  WHILE FOUND
	LOOP 
        FETCH cur_AlunoFreq INTO v_qtdalunos ; -- iteração
		END LOOP;
	CLOSE cur_AlunoFreq;
	-- 4. Apresentando as variáveis solicitadas -> quantidade de alunos que costumam se preparar com frequência
	RAISE NOTICE '%', v_qtdalunos;
END;
$$

-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui


-- ----------------------------------------------------------------