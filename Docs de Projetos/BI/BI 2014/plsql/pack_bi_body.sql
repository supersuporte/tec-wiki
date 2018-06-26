create or replace
PACKAGE BODY PACK_BI
IS

 ----------------
 -- LOG Inicio --
 ----------------
 FUNCTION log_inicio(inicio_fechamento    IN DATE,
                      fim_fechamento       IN DATE,
                      processo             IN VARCHAR2) RETURN NUMBER IS
 codigo_v NUMBER(11,2);
 
 BEGIN
    SELECT BILOG_CODIGO.nextval INTO codigo_v FROM DUAL;
    IF fim_fechamento IS NULL THEN
        INSERT INTO bilog (CODIGO,
                           INICIO_PROCESSAMENTO,
                           FIM_PROCESSAMENTO,
                           INICIO_FECHAMENTO,
                           FIM_FECHAMENTO,
                           PROCESSO)
             VALUES (codigo_v,
                     sysdate, 
                     null,
                     inicio_fechamento,
                     null,
                     processo);
    ELSE
        INSERT INTO bilog (CODIGO,
                           INICIO_PROCESSAMENTO,
                           FIM_PROCESSAMENTO,
                           INICIO_FECHAMENTO,
                           FIM_FECHAMENTO,
                           PROCESSO)
             VALUES (codigo_v,
                     sysdate, 
                     null,
                     inicio_fechamento,
                     fim_fechamento,
                     processo);

    END IF;
  COMMIT;
  RETURN(codigo_v);
 END;

 -------------
 -- LOG Fim --
 -------------
 PROCEDURE log_fim(codigo_bilog IN NUMBER) AS

 BEGIN

    UPDATE bilog SET FIM_PROCESSAMENTO = sysdate
     WHERE codigo = codigo_bilog;

  COMMIT;

 END log_fim;

 ----------------------------
 -- Grava devolucao bi0100 --
 ----------------------------
 PROCEDURE grava_abatimento(v_data           IN DATE,
                            v_cliente        IN bi0100.cliente%TYPE,
                            v_agrupamento    IN bi0100.agrupamento%TYPE,
                            v_subagrupamento IN bi0100.subagrupamento%TYPE,
                            v_quantidade     IN bi0100.quantidade%TYPE,
                            v_valor          IN bi0100.valor%TYPE)

 IS
    bi0100_quantidade bi0100.quantidade%TYPE;
    bi0100_valor      bi0100.valor%TYPE;

 BEGIN
   SELECT bi0100.quantidade,
          bi0100.valor
     INTO bi0100_quantidade, bi0100_valor
     FROM bi0100
    WHERE bi0100.data = v_data
      AND bi0100.cliente = v_cliente
      AND bi0100.agrupamento = v_agrupamento
      AND bi0100.subagrupamento = v_subagrupamento;

   UPDATE bi0100
      SET bi0100.quantidade = (bi0100_quantidade - v_quantidade),
          bi0100.valor      = (bi0100_valor - v_valor)
    WHERE bi0100.data = v_data
      AND bi0100.cliente = v_cliente
      AND bi0100.agrupamento = v_agrupamento
      AND bi0100.subagrupamento = v_subagrupamento;
    
    COMMIT;
    
 EXCEPTION
    WHEN NO_DATA_FOUND THEN

        INSERT INTO bi0100
             VALUES (bi0100_codigo.nextval,
                     v_data,
                     v_cliente,
                     v_agrupamento,
                     v_subagrupamento,
                     (0 - v_quantidade),
                     (0 - v_valor),
                     0,
                     0);
        COMMIT;

 END grava_abatimento;

 ---------------------------------------
 -- Busca as notas de credito e abate --
 ---------------------------------------
 PROCEDURE abate_nota_de_credito(inicio IN DATE,
                                 fim    IN DATE)

 IS

    data             bi0100.data%TYPE;
    cliente          bi0100.cliente%TYPE;
    agrupamento      bi0100.agrupamento%TYPE;
    subagrupamento   bi0100.subagrupamento%TYPE;
    quantidade_total bi0100.quantidade%TYPE :=0;
    valor_total      bi0100.valor%TYPE;

    valor            bi0100.valor%TYPE;

    CURSOR ncs_cursor IS
        SELECT fat0761.dat_emissao,
               fat235.cod_cliente,
               NVL(iat037.cod_agrupamento,'OU') cod_agrupamento,
               NVL(iat037.sub_agrupamento,'168') sub_agrupamento,
               NVL(iat177.cod_familia,'OU') cod_familia,
               NVL(fat0761.val_item,0) val_item
          FROM fat0761, fat0710, fat235, iat037, iat177
         WHERE fat0761.dat_emissao BETWEEN inicio AND fim
           AND fat0761.num_credito = fat0710.num_credito 
           AND fat0761.ano_credito = fat0710.ano_credito
               AND fat0710.num_titulo_nc = fat235.num_titulo 
               AND fat0710.ano_credito = fat0710.ano_credito
           AND fat0761.cod_produto = iat037.cod_grupo(+)
                                      || iat037.cod_subgrupo(+)
                                      || iat037.num_produto(+)
                                      || iat037.cod_unidade(+)
           AND iat037.cod_agrupamento = iat177.cod_agrupamento(+)
           AND iat037.sub_agrupamento = iat177.sub_agrupamento(+)
      ORDER BY fat0761.dat_emissao,
               fat235.cod_cliente,
               iat037.cod_agrupamento,
               iat037.sub_agrupamento; 

 BEGIN

   FOR ncs IN ncs_cursor LOOP

        valor := ncs.val_item;

        IF ncs.dat_emissao = data
          AND ncs.cod_cliente = cliente 
          AND ncs.cod_agrupamento = agrupamento 
          AND ncs.sub_agrupamento = subagrupamento THEN
                valor_total      := valor_total + valor;
        ELSE
            IF data IS NOT NULL THEN
                grava_abatimento(data, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
            END IF;

            data             := ncs.dat_emissao;
            cliente          := ncs.cod_cliente;
            agrupamento      := ncs.cod_agrupamento;
            subagrupamento   := ncs.sub_agrupamento;
            valor_total      := valor;

        END IF;

   END LOOP;

   IF data IS NOT NULL THEN
       grava_abatimento(data, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
   END IF;

 END abate_nota_de_credito;

 -----------------------------------------------
 -- Busca as NFs de entrada e abate devolucao --
 -----------------------------------------------
 PROCEDURE abate_devolucao(inicio IN DATE,
                           fim    IN DATE)

 IS

    data             bi0100.data%TYPE;
    cliente          bi0100.cliente%TYPE;
    agrupamento      bi0100.agrupamento%TYPE;
    subagrupamento   bi0100.subagrupamento%TYPE;
    quantidade_total bi0100.quantidade%TYPE;
    valor_total      bi0100.valor%TYPE;

    quantidade       bi0100.quantidade%TYPE;
    valor            bi0100.valor%TYPE;

    CURSOR nfs_cursor IS
        SELECT dat009.data_nf_entrada,
               fat017.cod_cliente,
               NVL(iat037.cod_agrupamento,'OU') cod_agrupamento,
               NVL(iat037.sub_agrupamento,'168') sub_agrupamento,
               NVL(iat177.cod_familia,'OU') cod_familia,
               NVL(dat009.qt_quarto_devol,0) qt_quarto_devol,
               NVL(dat009.devolucao_liqui,0) devolucao_liqui
          FROM dat009, dat1537, fat017, iat037, iat177
         WHERE dat009.cod_filial = '0101'
           AND dat009.data_nf_entrada BETWEEN inicio AND fim
           AND dat009.devolucao_liqui <> 0
               AND dat009.cod_filial = dat1537.cod_filial
               AND dat009.num_nf_entrada = dat1537.num_nf_entrada
               AND dat009.data_nf_entrada = dat1537.data_nf_entrada
               AND dat009.DESC_SERIE_NF = dat1537.desc_serie_nf
               AND dat009.cod_fornecedor = dat1537.cod_fornecedor
           AND dat1537.cod_cliente <> ' '
           AND dat1537.cod_cliente = fat017.cod_cliente
           AND dat009.cod_prod_acab = iat037.cod_grupo(+)
                                      || iat037.cod_subgrupo(+)
                                      || iat037.num_produto(+)
                                      || iat037.cod_unidade(+)
           AND iat037.cod_agrupamento = iat177.cod_agrupamento(+)
           AND iat037.sub_agrupamento = iat177.sub_agrupamento(+)
      ORDER BY dat009.data_nf_entrada,
               dat1537.cod_cliente,
               iat037.cod_agrupamento,
               iat037.sub_agrupamento;

 BEGIN

   FOR nfs IN nfs_cursor LOOP

        IF nfs.cod_familia = 'PT' OR nfs.cod_familia = 'OU' OR nfs.cod_familia = 'EV' THEN
           quantidade := 0;       
        ELSIF nfs.cod_familia = 'SC' THEN
           quantidade := nfs.qt_quarto_devol;
        ELSE
           quantidade := TRUNC((nfs.qt_quarto_devol / 4),2);
        END IF;

        valor := nfs.devolucao_liqui;


        IF nfs.data_nf_entrada = data
          AND nfs.cod_cliente = cliente 
          AND nfs.cod_agrupamento = agrupamento 
          AND nfs.sub_agrupamento = subagrupamento THEN
                quantidade_total := quantidade_total + quantidade;
                valor_total      := valor_total + valor;
        ELSE
            IF data IS NOT NULL THEN
                grava_abatimento(data, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
            END IF;

            data             := nfs.data_nf_entrada;
            cliente          := nfs.cod_cliente;
            agrupamento      := nfs.cod_agrupamento;
            subagrupamento   := nfs.sub_agrupamento;
            quantidade_total := quantidade;
            valor_total      := valor;

        END IF;

   END LOOP;

   IF data IS NOT NULL THEN
       grava_abatimento(data, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
   END IF;

 END abate_devolucao;
 
 -----------------------------------
 -- Grava vendas liquida - bi0100 --
 -----------------------------------
 PROCEDURE grava_vendas_liquida(data           IN bi0100.data%TYPE,
                                cliente        IN bi0100.cliente%TYPE,
                                agrupamento    IN bi0100.agrupamento%TYPE,
                                subagrupamento IN bi0100.subagrupamento%TYPE,
                                quantidade     IN bi0100.quantidade%TYPE,
                                valor          IN bi0100.valor%TYPE,
                                custo_liquido  IN bi0100.custo_liquido%TYPE,
                                custo_ggf      IN bi0100.custo_ggf%TYPE) AS
 BEGIN

    INSERT INTO bi0100
         VALUES (bi0100_codigo.nextval,
                 data,
                 cliente,
                 agrupamento,
                 subagrupamento,
                 quantidade,
                 valor,
                 custo_liquido,
                 custo_ggf);

    COMMIT;

 END grava_vendas_liquida;

 -------------------------------------
 -- Busca as NFs e chama a gravacao --
 -------------------------------------
 PROCEDURE processa_nfs(inicio IN DATE,
                        fim    IN DATE)

 IS

    data                bi0100.data%TYPE;
    cliente             bi0100.cliente%TYPE;
    agrupamento         bi0100.agrupamento%TYPE;
    subagrupamento      bi0100.subagrupamento%TYPE;
    quantidade_total    bi0100.quantidade%TYPE;
    valor_total         bi0100.valor%TYPE;
    custo_liquido_total bi0100.custo_liquido%TYPE;
    custo_ggf_total     bi0100.custo_ggf%TYPE;

    quantidade          bi0100.quantidade%TYPE;
    valor               bi0100.valor%TYPE;

    CURSOR nfs_cursor IS 
        SELECT cct058.num_nf,
               cct058.cod_cliente,
               cct059.data_emissao,
               NVL(cct059.qtd_item,0) qtd_item,
               cct059.qtd_quartos,
               cct059.venda_liquida,
               cct059.nat_oper,
               cct058.data_saida,
               cct058.flag_nf_complem,
               cct058.val_servico,
               NVL(iat066.qtd_litros,0) qtd_litros,
               NVL(iat037.cod_agrupamento,'OU') cod_agrupamento,
               NVL(iat037.sub_agrupamento,'168') sub_agrupamento,
               iat177.cod_familia,
               NVL(cut052.val_liq_custos,0) val_liq_custos,
               NVL(cut052.marg_contr_cus,0) marg_contr_cus
          FROM cct059,
               cct058,
               iat066,
               iat037,
               iat177,
               cut052
         WHERE (cct059.cod_filial      = cct058.cod_filial(+)
               AND cct059.num_nf       = cct058.num_nf(+)
               AND cct059.desc_serie   = cct058.desc_serie(+)
               AND cct059.desc_especie = cct058.desc_especie(+))
           AND cct058.data_emissao = cct059.data_emissao
           AND cct058.cod_status < '90'
           AND NVL(cct058.val_servico,0) = 0
           AND NVL(cct059.venda_liquida,0) <> 0
           AND (cct059.cod_grupo       = iat037.cod_grupo(+)
               AND cct059.cod_subgrupo = iat037.cod_subgrupo(+)
               AND cct059.num_produto  = iat037.num_produto(+)
               AND cct059.cod_unidade  = iat037.cod_unidade(+))
           AND cct059.cod_unidade = iat066.cod_unidade(+)
               AND iat037.cod_agrupamento = iat177.cod_agrupamento(+)
               AND iat037.sub_agrupamento = iat177.sub_agrupamento(+)
           AND (cct059.data_emissao between inicio and fim)
               AND cct059.cod_filial   = cut052.cod_filial(+)
               AND cct059.num_nf	   = cut052.num_nf(+)
               AND cct059.desc_serie   = cut052.desc_serie(+)
               AND cct059.desc_especie = cut052.desc_especie(+)
               AND cct059.num_item     = cut052.num_item(+)
        ORDER BY cct059.data_emissao,
                 cct058.cod_cliente,
                 iat037.cod_agrupamento,
                 iat037.sub_agrupamento;

 BEGIN

    FOR nfs IN nfs_cursor LOOP

        IF nfs.flag_nf_complem = 'P' OR SUBSTR(nfs.nat_oper, 2, 3) = '917' 
           OR nfs.cod_familia = 'PT' OR nfs.cod_familia = 'OU' OR nfs.cod_familia = 'EV' THEN
            quantidade := 0;
        ELSIF nfs.cod_familia = 'SC' THEN
            quantidade := TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2);
        ELSE
            quantidade := (TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2) / 4);
        END IF;

        valor := TRUNC(nfs.venda_liquida,2);

        
        IF nfs.data_emissao = data
          AND nfs.cod_cliente     = cliente 
          AND nfs.cod_agrupamento = agrupamento 
          AND nfs.sub_agrupamento = subagrupamento THEN
                quantidade_total    := quantidade_total + quantidade;
                valor_total         := valor_total + valor;
                custo_liquido_total := custo_liquido_total + nfs.val_liq_custos;
                custo_ggf_total     := custo_ggf_total + nfs.marg_contr_cus;
        ELSE
            IF data IS NOT NULL THEN
                grava_vendas_liquida(data, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
            END IF;

            data                := nfs.data_emissao;
            cliente             := nfs.cod_cliente;
            agrupamento         := nfs.cod_agrupamento;
            subagrupamento      := nfs.sub_agrupamento;
            quantidade_total    := quantidade;
            valor_total         := valor;
            custo_liquido_total := nfs.val_liq_custos;
            custo_ggf_total     := nfs.marg_contr_cus;

        END IF;

    END LOOP;

    IF data IS NOT NULL THEN
        grava_vendas_liquida(data, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
    END iF;

 END processa_nfs;
 
 ----------------------------
 -- Exclui dados do bi0100 --
 ----------------------------
 PROCEDURE exclui_vendas_liquida(inicio IN DATE,
                                 fim    IN DATE) AS

 BEGIN

    DELETE FROM bi0100
          WHERE data between inicio and fim;
    COMMIT;

 END exclui_vendas_liquida;

 ---------------------------
 -- Grava cutoff - bi0200 --
 ---------------------------
 PROCEDURE grava_cutoff(data           IN bi0200.data%TYPE,
                        cliente        IN bi0200.cliente%TYPE,
                        agrupamento    IN bi0200.agrupamento%TYPE,
                        subagrupamento IN bi0200.subagrupamento%TYPE,
                        quantidade     IN bi0200.quantidade%TYPE,
                        valor          IN bi0200.valor%TYPE,
                        custo_liquido  IN bi0200.custo_liquido%TYPE,
                        custo_ggf      IN bi0200.custo_ggf%TYPE) AS

 BEGIN

    INSERT INTO bi0200
         VALUES (bi0200_codigo.nextval,
                 data,
                 cliente,
                 agrupamento,
                 subagrupamento,
                 quantidade,
                 valor,
                 custo_liquido,
                 custo_ggf);

    COMMIT;

 END grava_cutoff;

 -----------------------------------------------
 -- Busca as NFs de cutoff e chama a gravacao --
 -----------------------------------------------
 PROCEDURE processa_nfs_cutoff(data IN DATE)

 IS

    cliente             bi0100.cliente%TYPE;
    agrupamento         bi0100.agrupamento%TYPE;
    subagrupamento      bi0100.subagrupamento%TYPE;
    quantidade_total    bi0100.quantidade%TYPE;
    valor_total         bi0100.valor%TYPE;
    custo_liquido_total bi0100.custo_liquido%TYPE;
    custo_ggf_total     bi0100.custo_ggf%TYPE;

    quantidade       bi0100.quantidade%TYPE;
    valor            bi0100.valor%TYPE;

    inicio           DATE := ADD_MONTHS(data, -1);
    fim              DATE := data-1;
    cutoff           DATE := data;

    CURSOR nfs_cursor IS 
        SELECT cct058.num_nf,
               cct058.cod_cliente,
               cct059.data_emissao,
               NVL(cct059.qtd_item,0) qtd_item,
               cct059.qtd_quartos,
               cct059.venda_liquida,
               cct059.nat_oper,
               cct058.data_saida,
               cct058.flag_nf_complem,
               cct058.val_servico,
               NVL(iat066.qtd_litros,0) qtd_litros,
               NVL(iat037.cod_agrupamento,'OU') cod_agrupamento,
               NVL(iat037.sub_agrupamento,'168') sub_agrupamento,
               iat177.cod_familia,
               NVL(cut052.val_liq_custos,0) val_liq_custos,
               NVL(cut052.marg_contr_cus,0) marg_contr_cus
          FROM cct059,
               cct058,
               iat066,
               iat037,
               iat177,
               cut052
         WHERE (cct059.cod_filial      = cct058.cod_filial(+)
               AND cct059.num_nf       = cct058.num_nf(+)
               AND cct059.desc_serie   = cct058.desc_serie(+)
               AND cct059.desc_especie = cct058.desc_especie(+))
           AND cct058.data_emissao = cct059.data_emissao
           AND cct058.cod_status < '90'
           AND NVL(cct058.val_servico,0) = 0
           AND NVL(cct059.venda_liquida,0) <> 0
           AND (cct059.cod_grupo       = iat037.cod_grupo(+)
               AND cct059.cod_subgrupo = iat037.cod_subgrupo(+)
               AND cct059.num_produto  = iat037.num_produto(+)
               AND cct059.cod_unidade  = iat037.cod_unidade(+))
           AND cct059.cod_unidade = iat066.cod_unidade(+)
               AND iat037.cod_agrupamento = iat177.cod_agrupamento(+)
               AND iat037.sub_agrupamento = iat177.sub_agrupamento(+)
           AND (cct059.data_emissao between inicio and fim)
           AND (cct058.data_saida IS NULL OR cct058.data_saida >= cutoff)
               AND cct059.cod_filial   = cut052.cod_filial(+)
               AND cct059.num_nf	   = cut052.num_nf(+)
               AND cct059.desc_serie   = cut052.desc_serie(+)
               AND cct059.desc_especie = cut052.desc_especie(+)
               AND cct059.num_item     = cut052.num_item(+)
        ORDER BY cct058.cod_cliente,
                 iat037.cod_agrupamento,
                 iat037.sub_agrupamento;

 BEGIN

    FOR nfs IN nfs_cursor LOOP

        IF nfs.flag_nf_complem = 'P' OR SUBSTR(nfs.nat_oper, 2, 3) = '917' 
           OR nfs.cod_familia = 'PT' OR nfs.cod_familia = 'OU' OR nfs.cod_familia = 'EV' THEN
            quantidade := 0;
        ELSIF nfs.cod_familia = 'SC' THEN
            quantidade := TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2);
        ELSE
            quantidade := (TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2) / 4);
        END IF;

        valor := TRUNC(nfs.venda_liquida,2);


        IF nfs.cod_cliente = cliente 
          AND nfs.cod_agrupamento = agrupamento 
          AND nfs.sub_agrupamento = subagrupamento THEN
                quantidade_total    := quantidade_total + quantidade;
                valor_total         := valor_total + valor;
                custo_liquido_total := custo_liquido_total + nfs.val_liq_custos;
                custo_ggf_total     := custo_ggf_total + nfs.marg_contr_cus;
        ELSE
            IF cliente IS NOT NULL THEN
                grava_cutoff(cutoff, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
            END IF;

            cliente             := nfs.cod_cliente;
            agrupamento         := nfs.cod_agrupamento;
            subagrupamento      := nfs.sub_agrupamento;
            quantidade_total    := quantidade;
            valor_total         := valor;
            custo_liquido_total := nfs.val_liq_custos;
            custo_ggf_total     := nfs.marg_contr_cus;

        END IF;

    END LOOP;

    IF cliente IS NOT NULL THEN
        grava_cutoff(cutoff, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
    END iF;

 END processa_nfs_cutoff;

 -----------------------------------------------------------------
 -- Busca as NFs de cutoff e chama a gravacao para cutoff anual --
 -----------------------------------------------------------------
 PROCEDURE processa_nfs_cutoff_anual(data IN DATE)

 IS

    cliente             bi0100.cliente%TYPE;
    agrupamento         bi0100.agrupamento%TYPE;
    subagrupamento      bi0100.subagrupamento%TYPE;
    quantidade_total    bi0100.quantidade%TYPE;
    valor_total         bi0100.valor%TYPE;
    custo_liquido_total bi0100.custo_liquido%TYPE;
    custo_ggf_total     bi0100.custo_ggf%TYPE;

    quantidade       bi0100.quantidade%TYPE;
    valor            bi0100.valor%TYPE;

    inicio           DATE := ADD_MONTHS(data, -12);
    fim              DATE := data-1;
    cutoff           DATE := data;

    CURSOR nfs_cursor IS 
        SELECT cct058.num_nf,
               cct058.cod_cliente,
               cct059.data_emissao,
               NVL(cct059.qtd_item,0) qtd_item,
               cct059.qtd_quartos,
               cct059.venda_liquida,
               cct059.nat_oper,
               cct058.dt_entrega_real,
               cct058.flag_nf_complem,
               cct058.val_servico,
               NVL(iat066.qtd_litros,0) qtd_litros,
               NVL(iat037.cod_agrupamento,'OU') cod_agrupamento,
               NVL(iat037.sub_agrupamento,'168') sub_agrupamento,
               iat177.cod_familia,
               NVL(cut052.val_liq_custos,0) val_liq_custos,
               NVL(cut052.marg_contr_cus,0) marg_contr_cus
          FROM cct059,
               cct058,
               iat066,
               iat037,
               iat177,
               cut052
         WHERE (cct059.cod_filial      = cct058.cod_filial(+)
               AND cct059.num_nf       = cct058.num_nf(+)
               AND cct059.desc_serie   = cct058.desc_serie(+)
               AND cct059.desc_especie = cct058.desc_especie(+))
           AND cct058.data_emissao = cct059.data_emissao
           AND cct058.cod_status < '90'
           AND NVL(cct058.val_servico,0) = 0
           AND NVL(cct059.venda_liquida,0) <> 0
           AND (cct059.cod_grupo       = iat037.cod_grupo(+)
               AND cct059.cod_subgrupo = iat037.cod_subgrupo(+)
               AND cct059.num_produto  = iat037.num_produto(+)
               AND cct059.cod_unidade  = iat037.cod_unidade(+))
           AND cct059.cod_unidade = iat066.cod_unidade(+)
               AND iat037.cod_agrupamento = iat177.cod_agrupamento(+)
               AND iat037.sub_agrupamento = iat177.sub_agrupamento(+)
           AND (cct059.data_emissao between inicio and fim)
           AND (cct058.dt_entrega_real IS NULL OR cct058.dt_entrega_real >= cutoff)
               AND cct059.cod_filial   = cut052.cod_filial(+)
               AND cct059.num_nf	   = cut052.num_nf(+)
               AND cct059.desc_serie   = cut052.desc_serie(+)
               AND cct059.desc_especie = cut052.desc_especie(+)
               AND cct059.num_item     = cut052.num_item(+)
        ORDER BY cct058.cod_cliente,
                 iat037.cod_agrupamento,
                 iat037.sub_agrupamento;

 BEGIN

    FOR nfs IN nfs_cursor LOOP

        IF nfs.flag_nf_complem = 'P' OR SUBSTR(nfs.nat_oper, 2, 3) = '917' 
           OR nfs.cod_familia = 'PT' OR nfs.cod_familia = 'OU' OR nfs.cod_familia = 'EV' THEN
            quantidade := 0;
        ELSIF nfs.cod_familia = 'SC' THEN
            quantidade := TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2);
        ELSE
            quantidade := (TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2) / 4);
        END IF;

        valor := TRUNC(nfs.venda_liquida,2);


        IF nfs.cod_cliente = cliente 
          AND nfs.cod_agrupamento = agrupamento 
          AND nfs.sub_agrupamento = subagrupamento THEN
                quantidade_total    := quantidade_total + quantidade;
                valor_total         := valor_total + valor;
                custo_liquido_total := custo_liquido_total + nfs.val_liq_custos;
                custo_ggf_total     := custo_ggf_total + nfs.marg_contr_cus;
        ELSE
            IF cliente IS NOT NULL THEN
                grava_cutoff(cutoff, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
            END IF;

            cliente             := nfs.cod_cliente;
            agrupamento         := nfs.cod_agrupamento;
            subagrupamento      := nfs.sub_agrupamento;
            quantidade_total    := quantidade;
            valor_total         := valor;
            custo_liquido_total := nfs.val_liq_custos;
            custo_ggf_total     := nfs.marg_contr_cus;

        END IF;

    END LOOP;

    IF cliente IS NOT NULL THEN
        grava_cutoff(cutoff, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
    END iF;

 END processa_nfs_cutoff_anual;

 ----------------------------
 -- Exclui dados do bi0200 --
 ----------------------------
 PROCEDURE exclui_cutoff(cutoff IN DATE) AS

 BEGIN

    DELETE FROM bi0200
          WHERE data = cutoff;
    COMMIT;

 END exclui_cutoff;

 ---------------------------------------------------------
 -- Chamada principal para processar as Vendas Liquidas --
 ---------------------------------------------------------
 PROCEDURE vendas_liquida(inicio IN DATE,
                          fim    IN DATE)

 IS

   v_inicio DATE;
   v_fim    DATE;
   codigo_v NUMBER(11,2);

 BEGIN

    IF inicio IS NULL THEN
        v_inicio := TO_CHAR(sysdate-5, 'dd/mm/yyyy');
        v_fim    := TO_CHAR(sysdate, 'dd/mm/yyyy');
    ELSE
        v_inicio := inicio;
        v_fim    := fim;
    END IF;

    codigo_v := log_inicio(v_inicio, v_fim, 'Vendas Liquida');

    exclui_vendas_liquida(v_inicio, v_fim);
    processa_nfs(v_inicio, v_fim);
    abate_devolucao(v_inicio, v_fim);
    abate_nota_de_credito(v_inicio, v_fim);
    
    log_fim(codigo_v);

 END vendas_liquida;
 
 -----------------------------------------------
 -- Chamada principal para processar o Cutoff --
 -----------------------------------------------
 PROCEDURE cutoff(data IN DATE)

 IS

   v_data DATE;
   codigo_v NUMBER(11,2);

 BEGIN

   IF data IS NULL THEN
       v_data := TO_CHAR(sysdate, 'dd/mm/yyyy');
   ELSE
       v_data := data;
   END IF;


   exclui_cutoff(v_data);
    
   IF TO_CHAR(v_data, 'MM') = '01' then
       codigo_v := log_inicio(v_data, NULL, 'Cutoff Anual');
       processa_nfs_cutoff_anual(v_data);
       log_fim(codigo_v);
   ELSE
       codigo_v := log_inicio(v_data, NULL, 'Cutoff');
       processa_nfs_cutoff(data);   
       log_fim(codigo_v);
   END IF;

 END cutoff;


 --**************************************************************************--
 -- ************************ FECHAMENTO POR PRODUTO *************************--
 --**************************************************************************--

 ----------------------------
 -- Grava devolucao bi0110 --
 ----------------------------
 PROCEDURE grava_abatimento_produto(v_data             IN DATE,
                                    v_cliente          IN bi0110.cliente%TYPE,
                                    v_produto_grupo    IN bi0110.produto_grupo%TYPE,
                                    v_produto_subgrupo IN bi0110.produto_subgrupo%TYPE,
                                    v_produto_numero   IN bi0110.produto_numero%TYPE,
                                    v_produto_unidade  IN bi0110.produto_unidade%TYPE,
                                    v_quantidade       IN bi0110.quantidade%TYPE,
                                    v_valor            IN bi0110.valor%TYPE)

 IS
    bi0110_quantidade bi0110.quantidade%TYPE;
    bi0110_valor      bi0110.valor%TYPE;

 BEGIN
   SELECT bi0110.quantidade,
          bi0110.valor
     INTO bi0110_quantidade, bi0110_valor
     FROM bi0110
    WHERE bi0110.data = v_data
      AND bi0110.cliente = v_cliente
      AND bi0110.produto_grupo    = v_produto_grupo
      AND bi0110.produto_subgrupo = v_produto_subgrupo
      AND bi0110.produto_numero   = v_produto_numero
      AND bi0110.produto_unidade  = v_produto_unidade;

   UPDATE bi0110
      SET bi0110.quantidade = (bi0110_quantidade - v_quantidade),
          bi0110.valor      = (bi0110_valor - v_valor)
    WHERE bi0110.data = v_data
      AND bi0110.cliente = v_cliente
      AND bi0110.produto_grupo    = v_produto_grupo
      AND bi0110.produto_subgrupo = v_produto_subgrupo
      AND bi0110.produto_numero   = v_produto_numero
      AND bi0110.produto_unidade  = v_produto_unidade;
    
    COMMIT;
    
 EXCEPTION
    WHEN NO_DATA_FOUND THEN

        INSERT INTO bi0110
             VALUES (bi0110_codigo.nextval,
                     v_data,
                     v_cliente,
                     v_produto_grupo,
                     v_produto_subgrupo,
                     v_produto_numero,
                     v_produto_unidade,
                     (0 - v_quantidade),
                     (0 - v_valor),
                     0,
                     0);
        COMMIT;

 END grava_abatimento_produto;

 -----------------------------------------------------
 -- Busca as notas de credito e abate - por produto --
 -----------------------------------------------------
 PROCEDURE abate_nota_de_credito_produto(inicio IN DATE,
                                         fim    IN DATE)

 IS

    data             bi0110.data%TYPE;
    cliente          bi0110.cliente%TYPE;
    produto_grupo    bi0110.produto_grupo%TYPE;
    produto_subgrupo bi0110.produto_subgrupo%TYPE;
    produto_numero   bi0110.produto_numero%TYPE;
    produto_unidade  bi0110.produto_unidade%TYPE;
    quantidade_total bi0110.quantidade%TYPE :=0;
    valor_total      bi0110.valor%TYPE;

    valor            bi0110.valor%TYPE;

    CURSOR ncs_cursor IS
        SELECT fat0761.dat_emissao,
               fat235.cod_cliente,
               NVL(iat037.cod_grupo, ' ') cod_grupo,
               NVL(iat037.cod_subgrupo, ' ') cod_subgrupo,
               NVL(iat037.num_produto, ' ') num_produto,
               NVL(iat037.cod_unidade, ' ') cod_unidade,
               NVL(fat0761.val_item,0) val_item
          FROM fat0761, fat0710, fat235, iat037
         WHERE fat0761.dat_emissao BETWEEN inicio AND fim
           AND fat0761.num_credito = fat0710.num_credito 
           AND fat0761.ano_credito = fat0710.ano_credito
               AND fat0710.num_titulo_nc = fat235.num_titulo 
               AND fat0710.ano_credito = fat0710.ano_credito
           AND fat0761.cod_produto = iat037.cod_grupo(+)
                                      || iat037.cod_subgrupo(+)
                                      || iat037.num_produto(+)
                                      || iat037.cod_unidade(+)
      ORDER BY fat0761.dat_emissao,
               fat235.cod_cliente,
               iat037.cod_grupo,
               iat037.cod_subgrupo,
               iat037.num_produto,
               iat037.cod_unidade;

 BEGIN

   FOR ncs IN ncs_cursor LOOP

        valor := ncs.val_item;

        IF ncs.dat_emissao = data
          AND ncs.cod_cliente = cliente 
          AND ncs.cod_grupo    = produto_grupo 
          AND ncs.cod_subgrupo = produto_subgrupo 
          AND ncs.num_produto  = produto_numero 
          AND ncs.cod_unidade  = produto_unidade THEN
                valor_total      := valor_total + valor;
        ELSE
            IF data IS NOT NULL THEN
                grava_abatimento_produto(data, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total);
            END IF;

            data             := ncs.dat_emissao;
            cliente          := ncs.cod_cliente;
            produto_grupo    := ncs.cod_grupo;
            produto_subgrupo := ncs.cod_subgrupo;
            produto_numero   := ncs.num_produto;
            produto_unidade  := ncs.cod_unidade;
            valor_total      := valor;

        END IF;

   END LOOP;

   IF data IS NOT NULL THEN
       grava_abatimento_produto(data, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total);
   END IF;

 END abate_nota_de_credito_produto;

 -----------------------------------------------------------
 -- Busca as NFs de entrada e abate devolucao por produto --
 -----------------------------------------------------------
 PROCEDURE abate_devolucao_produto(inicio IN DATE,
                                   fim    IN DATE)

 IS

    data             bi0110.data%TYPE;
    cliente          bi0110.cliente%TYPE;
    produto_grupo    bi0110.produto_grupo%TYPE;
    produto_subgrupo bi0110.produto_subgrupo%TYPE;
    produto_numero   bi0110.produto_numero%TYPE;
    produto_unidade  bi0110.produto_unidade%TYPE;
    quantidade_total bi0110.quantidade%TYPE;
    valor_total      bi0110.valor%TYPE;

    quantidade       bi0110.quantidade%TYPE;
    valor            bi0110.valor%TYPE;

    CURSOR nfs_cursor IS
        SELECT dat009.data_nf_entrada,
               fat017.cod_cliente,
               NVL(iat037.cod_grupo, ' ') cod_grupo,
               NVL(iat037.cod_subgrupo, ' ') cod_subgrupo,
               NVL(iat037.num_produto, ' ') num_produto,
               NVL(iat037.cod_unidade, ' ') cod_unidade,
               NVL(dat009.qt_quarto_devol,0) qt_quarto_devol,
               NVL(dat009.devolucao_liqui,0) devolucao_liqui
          FROM dat009, dat1537, fat017, iat037
         WHERE dat009.cod_filial = '0101'
           AND dat009.data_nf_entrada BETWEEN inicio AND fim
           AND dat009.devolucao_liqui <> 0
               AND dat009.cod_filial = dat1537.cod_filial
               AND dat009.num_nf_entrada = dat1537.num_nf_entrada
               AND dat009.data_nf_entrada = dat1537.data_nf_entrada
               AND dat009.DESC_SERIE_NF = dat1537.desc_serie_nf
               AND dat009.cod_fornecedor = dat1537.cod_fornecedor
           AND dat1537.cod_cliente <> ' '
           AND dat1537.cod_cliente = fat017.cod_cliente
           AND dat009.cod_prod_acab = iat037.cod_grupo(+)
                                      || iat037.cod_subgrupo(+)
                                      || iat037.num_produto(+)
                                      || iat037.cod_unidade(+)
      ORDER BY dat009.data_nf_entrada,
               dat1537.cod_cliente,
               iat037.cod_grupo,
               iat037.cod_subgrupo,
               iat037.num_produto,
               iat037.cod_unidade;

 BEGIN

   FOR nfs IN nfs_cursor LOOP

        quantidade := TRUNC((nfs.qt_quarto_devol / 4),2);
        valor := nfs.devolucao_liqui;

        IF nfs.data_nf_entrada = data
          AND nfs.cod_cliente = cliente 
          AND nfs.cod_grupo    = produto_grupo 
          AND nfs.cod_subgrupo = produto_subgrupo 
          AND nfs.num_produto  = produto_numero 
          AND nfs.cod_unidade  = produto_unidade THEN
                quantidade_total := quantidade_total + quantidade;
                valor_total      := valor_total + valor;
        ELSE
            IF data IS NOT NULL THEN
                grava_abatimento_produto(data, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total);
            END IF;

            data             := nfs.data_nf_entrada;
            cliente          := nfs.cod_cliente;
            produto_grupo    := nfs.cod_grupo;
            produto_subgrupo := nfs.cod_subgrupo;
            produto_numero   := nfs.num_produto;
            produto_unidade  := nfs.cod_unidade;
            quantidade_total := quantidade;
            valor_total      := valor;

        END IF;

   END LOOP;

   IF data IS NOT NULL THEN
       grava_abatimento_produto(data, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total);
   END IF;

 END abate_devolucao_produto;
 
 -----------------------------------
 -- Grava vendas liquida - bi0110 --
 -----------------------------------
 PROCEDURE grava_vendas_liquida_produto(data IN bi0110.data%TYPE,
                                        cliente          IN bi0110.cliente%TYPE,
                                        produto_grupo    IN bi0110.produto_grupo%TYPE,
                                        produto_subgrupo IN bi0110.produto_subgrupo%TYPE,
                                        produto_numero   IN bi0110.produto_numero%TYPE,
                                        produto_unidade  IN bi0110.produto_unidade%TYPE,
                                        quantidade       IN bi0110.quantidade%TYPE,
                                        valor            IN bi0110.valor%TYPE,
                                        custo_liquido    IN bi0110.custo_liquido%TYPE,
                                        custo_ggf        IN bi0110.custo_ggf%TYPE) AS

 BEGIN

    INSERT INTO bi0110
         VALUES (bi0110_codigo.nextval,
                 data,
                 cliente,
                 produto_grupo,
                 produto_subgrupo,
                 produto_numero,
                 produto_unidade,
                 quantidade,
                 valor,
                 custo_liquido,
                 custo_ggf);

    COMMIT;

 END grava_vendas_liquida_produto;

 -------------------------------------
 -- Busca as NFs e chama a gravacao --
 -------------------------------------
 PROCEDURE processa_nfs_produto(inicio IN DATE,
                                fim    IN DATE)

 IS

    data                bi0110.data%TYPE;
    cliente             bi0110.cliente%TYPE;
    produto_grupo       bi0110.produto_grupo%TYPE;
    produto_subgrupo    bi0110.produto_subgrupo%TYPE;
    produto_numero      bi0110.produto_numero%TYPE;
    produto_unidade     bi0110.produto_unidade%TYPE;
    quantidade_total    bi0110.quantidade%TYPE;
    valor_total         bi0110.valor%TYPE;
    custo_liquido_total bi0110.custo_liquido%TYPE;
    custo_ggf_total     bi0110.custo_ggf%TYPE;

    quantidade          bi0110.quantidade%TYPE;
    valor               bi0110.valor%TYPE;

    CURSOR nfs_cursor IS 
        SELECT cct058.num_nf,
               cct058.cod_cliente,
               cct059.data_emissao,
               NVL(cct059.qtd_item,0) qtd_item,
               cct059.qtd_quartos,
               cct059.venda_liquida,
               cct059.nat_oper,
               cct058.data_saida,
               cct058.flag_nf_complem,
               cct058.val_servico,
               NVL(iat066.qtd_litros,0) qtd_litros,
               NVL(iat037.cod_grupo, ' ') cod_grupo,
               NVL(iat037.cod_subgrupo, ' ') cod_subgrupo,
               NVL(iat037.num_produto, ' ') num_produto,
               NVL(iat037.cod_unidade, ' ') cod_unidade,
               NVL(cut052.val_liq_custos,0) val_liq_custos,
               NVL(cut052.marg_contr_cus,0) marg_contr_cus
          FROM cct059,
               cct058,
               iat066,
               iat037,
               cut052
         WHERE (cct059.cod_filial      = cct058.cod_filial(+)
               AND cct059.num_nf       = cct058.num_nf(+)
               AND cct059.desc_serie   = cct058.desc_serie(+)
               AND cct059.desc_especie = cct058.desc_especie(+))
           AND cct058.data_emissao = cct059.data_emissao
           AND cct058.cod_status < '90'
           AND NVL(cct058.val_servico,0) = 0
           AND NVL(cct059.venda_liquida,0) <> 0
           AND (cct059.cod_grupo       = iat037.cod_grupo(+)
               AND cct059.cod_subgrupo = iat037.cod_subgrupo(+)
               AND cct059.num_produto  = iat037.num_produto(+)
               AND cct059.cod_unidade  = iat037.cod_unidade(+))
           AND cct059.cod_unidade = iat066.cod_unidade(+)
           AND (cct059.data_emissao between inicio and fim)
               AND cct059.cod_filial   = cut052.cod_filial(+)
               AND cct059.num_nf	   = cut052.num_nf(+)
               AND cct059.desc_serie   = cut052.desc_serie(+)
               AND cct059.desc_especie = cut052.desc_especie(+)
               AND cct059.num_item     = cut052.num_item(+)
        ORDER BY cct059.data_emissao,
                 cct058.cod_cliente,
                 iat037.cod_grupo,
                 iat037.cod_subgrupo,
                 iat037.num_produto,
                 iat037.cod_unidade;

 BEGIN

    FOR nfs IN nfs_cursor LOOP

        IF nfs.flag_nf_complem = 'P' OR SUBSTR(nfs.nat_oper, 2, 3) = '917' THEN
            quantidade := 0;
        ELSE
            quantidade := (TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2) / 4);
        END IF;

        valor := TRUNC(nfs.venda_liquida,2);

        
        IF nfs.data_emissao = data
          AND nfs.cod_cliente  = cliente 
          AND nfs.cod_grupo    = produto_grupo 
          AND nfs.cod_subgrupo = produto_subgrupo 
          AND nfs.num_produto  = produto_numero 
          AND nfs.cod_unidade  = produto_unidade THEN
                quantidade_total    := quantidade_total + quantidade;
                valor_total         := valor_total + valor;
                custo_liquido_total := custo_liquido_total + nfs.val_liq_custos;
                custo_ggf_total     := custo_ggf_total + nfs.marg_contr_cus;
        ELSE
            IF data IS NOT NULL THEN
                grava_vendas_liquida_produto(data, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
            END IF;

            data                := nfs.data_emissao;
            cliente             := nfs.cod_cliente;
            produto_grupo       := nfs.cod_grupo;
            produto_subgrupo    := nfs.cod_subgrupo;
            produto_numero      := nfs.num_produto;
            produto_unidade     := nfs.cod_unidade;
            quantidade_total    := quantidade;
            valor_total         := valor;
            custo_liquido_total := nfs.val_liq_custos;
            custo_ggf_total     := nfs.marg_contr_cus;

        END IF;

    END LOOP;

    IF data IS NOT NULL THEN
        grava_vendas_liquida_produto(data, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
    END iF;

 END processa_nfs_produto;

 ----------------------------
 -- Exclui dados do bi0110 --
 ----------------------------
 PROCEDURE exclui_vendas_liquida_produto(inicio IN DATE,
                                         fim    IN DATE) AS

 BEGIN

    DELETE FROM bi0110
          WHERE data between inicio and fim;
    COMMIT;

 END exclui_vendas_liquida_produto;

 ---------------------------
 -- Grava cutoff - bi0210 --
 ---------------------------
 PROCEDURE grava_cutoff_produto(data     IN bi0210.data%TYPE,
                        cliente          IN bi0210.cliente%TYPE,
                        produto_grupo    IN bi0210.produto_grupo%TYPE,
                        produto_subgrupo IN bi0210.produto_subgrupo%TYPE,
                        produto_numero   IN bi0210.produto_numero%TYPE,
                        produto_unidade  IN bi0210.produto_unidade%TYPE,
                        quantidade       IN bi0210.quantidade%TYPE,
                        valor            IN bi0210.valor%TYPE,
                        custo_liquido    IN bi0210.custo_liquido%TYPE,
                        custo_ggf        IN bi0210.custo_ggf%TYPE) AS

 BEGIN

    INSERT INTO bi0210
         VALUES (bi0210_codigo.nextval,
                 data,
                 cliente,
                 produto_grupo,
                 produto_subgrupo,
                 produto_numero,
                 produto_unidade,
                 quantidade,
                 valor,
                 custo_liquido,
                 custo_ggf);

    COMMIT;

 END grava_cutoff_produto;

 ---------------------------------------------------------
 -- Busca as NFs de cutoff e chama a gravacao - produto --
 ---------------------------------------------------------
 PROCEDURE processa_nfs_cutoff_prod(data IN DATE)

 IS

    cliente             bi0110.cliente%TYPE;
    produto_grupo       bi0110.produto_grupo%TYPE;
    produto_subgrupo    bi0110.produto_subgrupo%TYPE;
    produto_numero      bi0110.produto_numero%TYPE;
    produto_unidade     bi0110.produto_unidade%TYPE;
    quantidade_total    bi0110.quantidade%TYPE;
    valor_total         bi0110.valor%TYPE;
    custo_liquido_total bi0110.custo_liquido%TYPE;
    custo_ggf_total     bi0110.custo_ggf%TYPE;

    quantidade       bi0110.quantidade%TYPE;
    valor            bi0110.valor%TYPE;

    inicio           DATE := ADD_MONTHS(data, -1);
    fim              DATE := data-1;
    cutoff           DATE := data;

    CURSOR nfs_cursor IS 
        SELECT cct058.num_nf,
               cct058.cod_cliente,
               cct059.data_emissao,
               NVL(cct059.qtd_item,0) qtd_item,
               cct059.qtd_quartos,
               cct059.venda_liquida,
               cct059.nat_oper,
               cct058.data_saida,
               cct058.flag_nf_complem,
               cct058.val_servico,
               NVL(iat066.qtd_litros,0) qtd_litros,
               NVL(iat037.cod_grupo, ' ') cod_grupo,
               NVL(iat037.cod_subgrupo, ' ') cod_subgrupo,
               NVL(iat037.num_produto, ' ') num_produto,
               NVL(iat037.cod_unidade, ' ') cod_unidade,
               NVL(cut052.val_liq_custos,0) val_liq_custos,
               NVL(cut052.marg_contr_cus,0) marg_contr_cus
          FROM cct059,
               cct058,
               iat066,
               iat037,
               cut052
         WHERE (cct059.cod_filial      = cct058.cod_filial(+)
               AND cct059.num_nf       = cct058.num_nf(+)
               AND cct059.desc_serie   = cct058.desc_serie(+)
               AND cct059.desc_especie = cct058.desc_especie(+))
           AND cct058.data_emissao = cct059.data_emissao
           AND cct058.cod_status < '90'
           AND NVL(cct058.val_servico,0) = 0
           AND NVL(cct059.venda_liquida,0) <> 0
           AND (cct059.cod_grupo       = iat037.cod_grupo(+)
               AND cct059.cod_subgrupo = iat037.cod_subgrupo(+)
               AND cct059.num_produto  = iat037.num_produto(+)
               AND cct059.cod_unidade  = iat037.cod_unidade(+))
           AND cct059.cod_unidade = iat066.cod_unidade(+)
           AND (cct059.data_emissao between inicio and fim)
           AND (cct058.data_saida IS NULL OR cct058.data_saida >= cutoff)
               AND cct059.cod_filial   = cut052.cod_filial(+)
               AND cct059.num_nf	   = cut052.num_nf(+)
               AND cct059.desc_serie   = cut052.desc_serie(+)
               AND cct059.desc_especie = cut052.desc_especie(+)
               AND cct059.num_item     = cut052.num_item(+)
        ORDER BY cct058.cod_cliente,
                 iat037.cod_grupo,
                 iat037.cod_subgrupo,
                 iat037.num_produto,
                 iat037.cod_unidade;

 BEGIN

    FOR nfs IN nfs_cursor LOOP

        IF nfs.flag_nf_complem = 'P' OR SUBSTR(nfs.nat_oper, 2, 3) = '917' THEN
            quantidade := 0;
        ELSE
            quantidade := (TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2) / 4);
        END IF;

        valor := TRUNC(nfs.venda_liquida,2);


        IF nfs.cod_cliente = cliente 
          AND nfs.cod_grupo    = produto_grupo 
          AND nfs.cod_subgrupo = produto_subgrupo 
          AND nfs.num_produto  = produto_numero 
          AND nfs.cod_unidade  = produto_unidade THEN
                quantidade_total    := quantidade_total + quantidade;
                valor_total         := valor_total + valor;
                custo_liquido_total := custo_liquido_total + nfs.val_liq_custos;
                custo_ggf_total     := custo_ggf_total + nfs.marg_contr_cus;
        ELSE
            IF cliente IS NOT NULL THEN
                grava_cutoff_produto(cutoff, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
            END IF;

            cliente             := nfs.cod_cliente;
            produto_grupo       := nfs.cod_grupo;
            produto_subgrupo    := nfs.cod_subgrupo;
            produto_numero      := nfs.num_produto;
            produto_unidade     := nfs.cod_unidade;
            quantidade_total    := quantidade;
            valor_total         := valor;
            custo_liquido_total := nfs.val_liq_custos;
            custo_ggf_total     := nfs.marg_contr_cus;

        END IF;

    END LOOP;

    IF cliente IS NOT NULL THEN
        grava_cutoff_produto(cutoff, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
    END iF;

 END processa_nfs_cutoff_prod;

 ---------------------------------------------------------------------------
 -- Busca as NFs de cutoff e chama a gravacao para cutoff anual - produto --
 ---------------------------------------------------------------------------
 PROCEDURE processa_nfs_cutoff_anual_prod(data IN DATE)

 IS

    cliente             bi0110.cliente%TYPE;
    produto_grupo       bi0110.produto_grupo%TYPE;
    produto_subgrupo    bi0110.produto_subgrupo%TYPE;
    produto_numero      bi0110.produto_numero%TYPE;
    produto_unidade     bi0110.produto_unidade%TYPE;
    quantidade_total    bi0110.quantidade%TYPE;
    valor_total         bi0110.valor%TYPE;
    custo_liquido_total bi0110.custo_liquido%TYPE;
    custo_ggf_total     bi0110.custo_ggf%TYPE;

    quantidade       bi0110.quantidade%TYPE;
    valor            bi0110.valor%TYPE;

    inicio           DATE := ADD_MONTHS(data, -12);
    fim              DATE := data-1;
    cutoff           DATE := data;

    CURSOR nfs_cursor IS 
        SELECT cct058.num_nf,
               cct058.cod_cliente,
               cct059.data_emissao,
               NVL(cct059.qtd_item,0) qtd_item,
               cct059.qtd_quartos,
               cct059.venda_liquida,
               cct059.nat_oper,
               cct058.dt_entrega_real,
               cct058.flag_nf_complem,
               cct058.val_servico,
               NVL(iat066.qtd_litros,0) qtd_litros,
               NVL(iat037.cod_grupo, ' ') cod_grupo,
               NVL(iat037.cod_subgrupo, ' ') cod_subgrupo,
               NVL(iat037.num_produto, ' ') num_produto,
               NVL(iat037.cod_unidade, ' ') cod_unidade,
               NVL(cut052.val_liq_custos,0) val_liq_custos,
               NVL(cut052.marg_contr_cus,0) marg_contr_cus
          FROM cct059,
               cct058,
               iat066,
               iat037,
               cut052
         WHERE (cct059.cod_filial      = cct058.cod_filial(+)
               AND cct059.num_nf       = cct058.num_nf(+)
               AND cct059.desc_serie   = cct058.desc_serie(+)
               AND cct059.desc_especie = cct058.desc_especie(+))
           AND cct058.data_emissao = cct059.data_emissao
           AND cct058.cod_status < '90'
           AND NVL(cct058.val_servico,0) = 0
           AND NVL(cct059.venda_liquida,0) <> 0
           AND (cct059.cod_grupo       = iat037.cod_grupo(+)
               AND cct059.cod_subgrupo = iat037.cod_subgrupo(+)
               AND cct059.num_produto  = iat037.num_produto(+)
               AND cct059.cod_unidade  = iat037.cod_unidade(+))
           AND cct059.cod_unidade = iat066.cod_unidade(+)
           AND (cct059.data_emissao between inicio and fim)
           AND (cct058.dt_entrega_real IS NULL OR cct058.dt_entrega_real >= cutoff)
               AND cct059.cod_filial   = cut052.cod_filial(+)
               AND cct059.num_nf	   = cut052.num_nf(+)
               AND cct059.desc_serie   = cut052.desc_serie(+)
               AND cct059.desc_especie = cut052.desc_especie(+)
               AND cct059.num_item     = cut052.num_item(+)
        ORDER BY cct058.cod_cliente,
                 iat037.cod_grupo,
                 iat037.cod_subgrupo,
                 iat037.num_produto,
                 iat037.cod_unidade;

 BEGIN

    FOR nfs IN nfs_cursor LOOP

        IF nfs.flag_nf_complem = 'P' OR SUBSTR(nfs.nat_oper, 2, 3) = '917' THEN
            quantidade := 0;
        ELSE
            quantidade := (TRUNC(((nfs.qtd_item * nfs.qtd_litros) / 0.9),2) / 4);
        END IF;

        valor := TRUNC(nfs.venda_liquida,2);


        IF nfs.cod_cliente = cliente 
          AND nfs.cod_grupo    = produto_grupo 
          AND nfs.cod_subgrupo = produto_subgrupo 
          AND nfs.num_produto  = produto_numero 
          AND nfs.cod_unidade  = produto_unidade THEN
                quantidade_total    := quantidade_total + quantidade;
                valor_total         := valor_total + valor;
                custo_liquido_total := custo_liquido_total + nfs.val_liq_custos;
                custo_ggf_total     := custo_ggf_total + nfs.marg_contr_cus;
        ELSE
            IF cliente IS NOT NULL THEN
                grava_cutoff_produto(cutoff, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
            END IF;

            cliente             := nfs.cod_cliente;
            produto_grupo       := nfs.cod_grupo;
            produto_subgrupo    := nfs.cod_subgrupo;
            produto_numero      := nfs.num_produto;
            produto_unidade     := nfs.cod_unidade;
            quantidade_total    := quantidade;
            valor_total         := valor;
            custo_liquido_total := nfs.val_liq_custos;
            custo_ggf_total     := nfs.marg_contr_cus;

        END IF;

    END LOOP;

    IF cliente IS NOT NULL THEN
        grava_cutoff_produto(cutoff, TO_NUMBER(cliente, '99999'), produto_grupo, produto_subgrupo, produto_numero, produto_unidade, quantidade_total, valor_total, custo_liquido_total, custo_ggf_total);
    END iF;

 END processa_nfs_cutoff_anual_prod;

 ----------------------------
 -- Exclui dados do bi0210 --
 ----------------------------
 PROCEDURE exclui_cutoff_produto(cutoff IN DATE) AS

 BEGIN

    DELETE FROM bi0210
          WHERE data = cutoff;
    COMMIT;

 END exclui_cutoff_produto;
 
 ---------------------------------------------------------------------
 -- Chamada principal para processar as Vendas Liquidas por produto --
 ---------------------------------------------------------------------
 PROCEDURE vendas_liquida_produto(inicio IN DATE,
                                  fim    IN DATE)

 IS

   v_inicio DATE;
   v_fim    DATE;
   codigo_v NUMBER(11,2);

 BEGIN

    IF inicio IS NULL THEN
        v_inicio := TO_CHAR(sysdate-5, 'dd/mm/yyyy');
        v_fim    := TO_CHAR(sysdate, 'dd/mm/yyyy');
    ELSE
        v_inicio := inicio;
        v_fim    := fim;
    END IF;
    
    codigo_v := log_inicio(v_inicio, v_fim, 'Vendas Liquida por Produto');

    exclui_vendas_liquida_produto(v_inicio, v_fim);
    processa_nfs_produto(v_inicio, v_fim);
    abate_devolucao_produto(v_inicio, v_fim);
    abate_nota_de_credito_produto(v_inicio, v_fim);
    
    log_fim(codigo_v);

 END vendas_liquida_produto;

 -----------------------------------------------------------
 -- Chamada principal para processar o Cutoff por produto --
 -----------------------------------------------------------
 PROCEDURE cutoff_produto(data IN DATE)

 IS

   v_data DATE;
   codigo_v NUMBER(11,2);

 BEGIN

   IF data IS NULL THEN
       v_data := TO_CHAR(sysdate, 'dd/mm/yyyy');
   ELSE
       v_data := data;
   END IF;

   exclui_cutoff_produto(data);
    
   IF TO_CHAR(v_data, 'MM') = '01' then
       codigo_v := log_inicio(v_data, NULL, 'Cutoff por Produto Anual');
       processa_nfs_cutoff_anual_prod(v_data);
       log_fim(codigo_v);
   ELSE
       codigo_v := log_inicio(v_data, NULL, 'Cutoff por Produto');
       processa_nfs_cutoff_prod(data);   
       log_fim(codigo_v);
   END IF;

 END cutoff_produto;
 
 --------------------------------
 -- Atualiza Materilized Views --
 --------------------------------
 PROCEDURE atualiza_fechamento_mviews(nada VARCHAR2)
 
 IS
   codigo_v NUMBER(11,2);
 
 BEGIN
   codigo_v := log_inicio(NULL, NULL, 'BIV101 - Vendas Liquida por Representante');
   DBMS_MVIEW.REFRESH('BIV101');
   log_fim(codigo_v);
    
   codigo_v := log_inicio(NULL, NULL, 'BIV103 - Vendas Liquida por Gerência');
   DBMS_MVIEW.REFRESH('BIV103');
   log_fim(codigo_v);
 
 END atualiza_fechamento_mviews;

END PACK_BI;