--------------------------------------
--- SCRIPT PARA INCLUSÃO DA MARGEM ---
--------------------------------------
alter table bi0100 add custo_liquido number(10,2);
alter table bi0100 add custo_ggf number(12,2);

UPDATE bi0100 SET CUSTO_LIQUIDO = 0, CUSTO_GGF = 0;
commit;

alter table bi0100 modify custo_liquido number(10,2) not null;
alter table bi0100 modify custo_ggf number(12,2) not null;

--------------------------------------
alter table bi0110 add custo_liquido number(10,2);
alter table bi0110 add custo_ggf number(12,2);

UPDATE BI0110 SET CUSTO_LIQUIDO = 0, CUSTO_GGF = 0;
commit;

alter table bi0110 modify custo_liquido number(10,2) not null;
alter table bi0110 modify custo_ggf number(12,2) not null;

--------------------------------------
alter table bi0200 add custo_liquido number(10,2);
alter table bi0200 add custo_ggf number(12,2);

UPDATE bi0200 SET CUSTO_LIQUIDO = 0, CUSTO_GGF = 0;
commit;

alter table bi0200 modify custo_liquido number(10,2) not null;
alter table bi0200 modify custo_ggf number(12,2) not null;

--------------------------------------
alter table bi0210 add custo_liquido number(10,2);
alter table bi0210 add custo_ggf number(12,2);

UPDATE BI0210 SET CUSTO_LIQUIDO = 0, CUSTO_GGF = 0;
commit;

alter table bi0210 modify custo_liquido number(10,2) not null;
alter table bi0210 modify custo_ggf number(12,2) not null;


---------------------------------
CREATE INDEX FONTES.CUT052_INDEX11 
ON CUT052 CUT052 (COD_FILIAL,NUM_NF,DESC_SERIE,DESC_ESPECIE,NUM_ITEM)
TABLESPACE "TB_INDICES_FONTES"
;
