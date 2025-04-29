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
    FROM %i
    WHERE GRADE > $1 
    AND (MOTHER_EDU = %2 OR FATHER_EDU = %3)',
     v_nometabela
  ) USING v_nota, v_maephd, v_paiphd;
    LOOP
--3. Recuperação de dados
        FETCH cur_AlunosAprovado INTO v_aluno;
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


-- ----------------------------------------------------------------
-- 4 Salário versus estudos
--escreva a sua solução aqui


-- ----------------------------------------------------------------
-- 5. Limpeza de valores NULL
--escreva a sua solução aqui

-- ----------------------------------------------------------------