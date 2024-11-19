CREATE TABLE empregado (
    rg    NUMBER(9, 0) PRIMARY KEY,
    nome   VARCHAR2(40 CHAR) NOT NULL,
    cpf    NUMBER(11, 0) UNIQUE NOT NULL,
    depto    INTEGER NOT NULL,
    rg_supervisor    NUMBER(9, 0),
    salario    NUMBER(7, 2) NOT NULL
);

CREATE TABLE departamento (
    nome  VARCHAR2(30 CHAR) NOT NULL,
    numero  NUMBER(1,0) PRIMARY KEY,
    rg_gerente  NUMBER(9,0) NOT NULL
);


CREATE TABLE projeto (
    projeto_nome        VARCHAR2(30 CHAR) NOT NULL,
    projeto_numero      NUMBER(3, 0) NOT NULL,
    projeto_localizacao VARCHAR2(40 CHAR) NOT NULL  
);


CREATE TABLE empregado_projeto (
    empregado_projeto_rg_empregado   NUMBER(9, 0) NOT NULL,
    empregado_projeto_numero_projeto   NUMBER(3, 0) NOT NULL,
    empregado_projeto_horas   NUMBER(3, 0) NOT NULL
    
);

CREATE TABLE depto_proj (
    depto_proj_numero_departamento   NUMBER(1, 0) NOT NULL,
    depto_proj_numero_projeto   NUMBER(3, 0) NOT NULL
    
);

CREATE TABLE dependente (
    dependente_rg_responsavel   NUMBER(9, 0) NOT NULL,
    dependente_rg               NUMBER(9, 0) NOT NULL,
    dependente_nome             VARCHAR2(30 CHAR) NOT NULL,
    dependente_nascimento       VARCHAR(10 CHAR) NOT NULL,
    dependente_relacao          VARCHAR2(10 CHAR) NOT NULL,
    dependente_sexo             VARCHAR2(10 CHAR) NOT NULL
    
);

-- Inserção de dados na tabela DEPARTAMENTO
INSERT INTO DEPARTAMENTO VALUES ('Contabilidade', 1, 10101010);
INSERT INTO DEPARTAMENTO VALUES ('Engenharia Civil', 2, 30303030);
INSERT INTO DEPARTAMENTO VALUES ('Engenharia Mecânica', 3, 20202020);

-- Inserção de dados na tabela EMPREGADO
INSERT INTO EMPREGADO VALUES ('João Luiz', 10101010, 11111111, 1, NULL, 3000.00);
INSERT INTO EMPREGADO VALUES ('Fernando', 20202020, 22222222, 2, 10101010, 2500.00);
INSERT INTO EMPREGADO VALUES ('Ricardo', 30303030, 33333333, 2, 10101010, 2300.00);
INSERT INTO EMPREGADO VALUES ('Jorge', 40404040, 44444444, 2, 20202020, 4200.00);
INSERT INTO EMPREGADO VALUES ('Renato', 50505050, 55555555, 3, 20202020, 1300.00);

-- Inserção de dados na tabela PROJETO
INSERT INTO PROJETO VALUES ('Financeiro 1', 5, 'São Paulo');
INSERT INTO PROJETO VALUES ('Motor 3', 10, 'Rio Claro');
INSERT INTO PROJETO VALUES ('Prédio Central', 20, 'Campinas');

-- Inserção de dados na tabela DEPENDENTES
INSERT INTO DEPENDENTES VALUES (10101010, 'Jorge', TO_DATE('27/12/1986', 'DD/MM/YYYY'), 'Filho', 'Masculino');
INSERT INTO DEPENDENTES VALUES (10101010, 'Luiz', TO_DATE('18/11/1979', 'DD/MM/YYYY'), 'Filho', 'Masculino');
INSERT INTO DEPENDENTES VALUES (20202020, 'Fernanda', TO_DATE('14/02/1969', 'DD/MM/YYYY'), 'Cônjuge', 'Feminino');
INSERT INTO DEPENDENTES VALUES (20202020, 'Ângelo', TO_DATE('10/02/1995', 'DD/MM/YYYY'), 'Filho', 'Masculino');
INSERT INTO DEPENDENTES VALUES (30303030, 'Adreia', TO_DATE('01/05/1990', 'DD/MM/YYYY'), 'Filho', 'Feminino');

-- Inserção de dados na tabela DEPARTAMENTO_PROJETO
INSERT INTO DEPARTAMENTO_PROJETO VALUES (2, 5);
INSERT INTO DEPARTAMENTO_PROJETO VALUES (2, 10);
INSERT INTO DEPARTAMENTO_PROJETO VALUES (2, 20);

-- Inserção de dados na tabela EMPREGADO_PROJETO
INSERT INTO EMPREGADO_PROJETO VALUES (20202020, 5, 10);
INSERT INTO EMPREGADO_PROJETO VALUES (20202020, 10, 25);
INSERT INTO EMPREGADO_PROJETO VALUES (30303030, 5, 35);
INSERT INTO EMPREGADO_PROJETO VALUES (40404040, 20, 20);
INSERT INTO EMPREGADO_PROJETO VALUES (50505050, 20, 25);

-- chave estrangeira empregado - departamento
ALTER TABLE empregado
    ADD CONSTRAINT empregado_departamento_fk FOREIGN KEY ( depto )
        REFERENCES departamento ( numero );

-- chave estrangeira empregado - supervisor
ALTER TABLE empregado
    ADD CONSTRAINT empregado_departamento_fk FOREIGN KEY ( rg_supervisor )
        REFERENCES empregado ( rg );

-- chave estrangeira departamento - empregado
ALTER TABLE departamento
    ADD CONSTRAINT departamento_empregado_fk FOREIGN KEY ( rg_gerente )
        REFERENCES empregado ( rg );

ALTER TABLE empregado_projeto
    ADD CONSTRAINT empregado_projeto_empregado_fk FOREIGN KEY ( empregado_projeto_rg_empregado )
        REFERENCES empregado ( empregado_rg );


ALTER TABLE empregado_projeto
    ADD CONSTRAINT empregado_projeto_projeto_fk FOREIGN KEY ( empregado_projeto_numero_projeto )
        REFERENCES projeto ( projeto_numero );

ALTER TABLE depto_proj
    ADD CONSTRAINT depto_proj_departamento_fk FOREIGN KEY ( depto_proj_numero_departamento )
        REFERENCES departamento ( departamento_numero );


ALTER TABLE depto_proj
    ADD CONSTRAINT depto_proj_projeto_fk FOREIGN KEY ( depto_proj_numero_projeto )
        REFERENCES projeto ( projeto_numero );

ALTER TABLE dependente ADD CONSTRAINT dependente_pk PRIMARY KEY ( dependente_rg );

ALTER TABLE dependente
    ADD CONSTRAINT dependente_empregado_fk FOREIGN KEY ( dependente_rg_responsavel )
        REFERENCES empregado ( empregado_rg );

ALTER TABLE projeto ADD CONSTRAINT projeto_pk PRIMARY KEY ( projeto_numero );