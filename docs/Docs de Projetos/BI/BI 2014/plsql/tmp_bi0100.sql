CREATE TABLE "FONTES"."BI0100"
  (
    "CODIGO" NUMBER(10,0) NOT NULL ENABLE,
    "DATA" DATE NOT NULL ENABLE,
    "CLIENTE"        NUMBER(5,0) NOT NULL ENABLE,
    "AGRUPAMENTO"    VARCHAR2(2 BYTE) NOT NULL ENABLE,
    "SUBAGRUPAMENTO" VARCHAR2(3 BYTE) NOT NULL ENABLE,
    "QUANTIDADE"     NUMBER(8,2) NOT NULL ENABLE,
    "VALOR"          NUMBER(8,2) NOT NULL ENABLE,
    CONSTRAINT "BI0100_INDEX01" PRIMARY KEY ("CODIGO") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT) TABLESPACE "TB_INDICES_FONTES" ENABLE
  )
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "TB_DADOS_FONTES" ;
CREATE UNIQUE INDEX "FONTES"."BI0100_INDEX01" ON "FONTES"."BI0100"
  (
    "CODIGO"
  )
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "TB_INDICES_FONTES" ;
CREATE UNIQUE INDEX "FONTES"."BI0100_INDEX02" ON "FONTES"."BI0100"
  (
    "DATA", "CLIENTE", "AGRUPAMENTO", "SUBAGRUPAMENTO"
  )
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
  )
  TABLESPACE "TB_INDICES_FONTES" ;
  CREATE INDEX "FONTES"."BI0100_INDEX03" ON "FONTES"."BI0100"
    (
      "DATA",
      "CLIENTE"
    )
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE
    (
      INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
    TABLESPACE "TB_DADOS_FONTES" ;
  CREATE INDEX "FONTES"."BI0100_INDEX04" ON "FONTES"."BI0100"
    (
      "DATA"
    )
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE
    (
      INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
    TABLESPACE "TB_DADOS_FONTES" ;
  CREATE INDEX "FONTES"."BI0100_INDEX05" ON "FONTES"."BI0100"
    (
      "AGRUPAMENTO",
      "SUBAGRUPAMENTO"
    )
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE
    (
      INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
    TABLESPACE "TB_DADOS_FONTES" ;
  CREATE INDEX "FONTES"."BI0100_INDEX06" ON "FONTES"."BI0100"
    (
      "CLIENTE"
    )
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE
    (
      INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
    TABLESPACE "TB_DADOS_FONTES" ;


CREATE SEQUENCE "FONTES"."BI0100_CODIGO" MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1 CACHE 50 NOORDER NOCYCLE ;