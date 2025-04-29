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
DO $$
DECLARE
   -- 1. Declaração cursor
   cur_AlunosAprovados REFCURSOR;
   -- Variável para armazenar
   v_aluno VARCHAR(200);
   v_nota INT := 0;
   v_paiphd INT := 6;
   v_maephd INT := 6;
   v_nometabela VARCHAR(200) := 'tb_students_performance';
BEGIN
  -- 2. Abertura do cursor
  OPEN cur_AlunosAprovados FOR EXECUTE 
  format(
    'SELECT
        STUDENTID
    FROM %s
    WHERE GRADE > $1 
    AND (MOTHER_EDU = $2 OR FATHER_EDU = $3)',
     v_nometabela
  ) USING v_nota, v_maephd, v_paiphd;
    LOOP
--3. Recuperação de dados
        FETCH FROM cur_AlunosAprovados INTO v_aluno;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%' , v_aluno;
    END LOOP;
--4. Fechamento
    CLOSE cur_AlunosAprovados;
END;
$$
 
-- ----------------------------------------------------------------
-- 3 Resultado em função dos estudos
--escreva a sua solução aqui
DO $$
DECLARE
  cur_alunosaprovados REFCURSOR;
  v_GRADE INT := NOT 0;
  v_PREP_STUDY INT;
    v_qtdalunosaprovado INT;
BEGIN
OPEN cur_alunosaprovados FOR EXECUTE
    format
    ('
    SELECT
    PREP_STUDY, GRADE
    FROM
    tb_students_performance
    WHERE (v_PREP_STUDY = 1) AND (GRADE NOT 0)
    ',
    v_qtdalunosaprovados
);
    LOOP
        FETCH cur_alunosaprovados INTO v_qtdalunosaprovados;
        EXIT WHEN NOT FOUND;
    RAISE NOTICE '%', v_qtdalunosaprovados;
    END LOOP;
    CLOSE cur_alunosaprovados;
END;
$$


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
DO $$
DECLARE
    cur_deletenull REFCURSOR;
    tupla RECORD;
BEGIN
-- scroll para poder voltar ao início
    OPEN cur_deletenull SCROLL FOR
    SELECT
    *
    FROM
    tb_students_performance;
    LOOP
        FETCH cur_deletenull INTO tupla;
        EXIT WHEN NOT FOUND;
        IF tupla.GRADE IS NULL THEN
        DELETE FROM tb_students_performance WHERE CURRENT OF cur_deletenull;
        END IF;
    END LOOP;
    --tuplas remanescentes, de baixo para cima
    LOOP
        FETCH BACKWARD FROM cur_deletenull INTO tupla;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', tupla;
    END LOOP;
    CLOSE cur_deletenull;
END;
$$

-- ----------------------------------------------------------------