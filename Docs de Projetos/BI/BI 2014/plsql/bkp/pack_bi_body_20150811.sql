create or replace
PACKAGE BODY PACK_BI
IS

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
                     (0 - v_valor));
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
               NVL(iat037.sub_agrupamento,'082') sub_agrupamento,
               NVL(iat177.cod_familia,'ou') cod_familia,
               NVL(fat0761.val_item,0) val_item
          FROM fat0761, fat0710, fat235, iat037, iat177
         WHERE fat0761.dat_emissao BETWEEN inicio AND fim
           AND fat0761.num_credito = fat0710.num_credito
           AND fat0710.num_titulo_nc = fat235.num_titulo
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
               NVL(iat037.sub_agrupamento,'082') sub_agrupamento,
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
                                valor          IN bi0100.valor%TYPE) AS
 BEGIN

    INSERT INTO bi0100
         VALUES (bi0100_codigo.nextval,
                 data,
                 cliente,
                 agrupamento,
                 subagrupamento,
                 quantidade,
                 valor);

    COMMIT;

 END grava_vendas_liquida;

 -------------------------------------
 -- Busca as NFs e chama a gravacao --
 -------------------------------------
 PROCEDURE processa_nfs(inicio IN DATE,
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
               NVL(iat037.sub_agrupamento,'082') sub_agrupamento,
               iat177.cod_familia
          FROM cct059,
               cct058,
               iat066,
               iat037,
               iat177
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
                quantidade_total := quantidade_total + quantidade;
                valor_total      := valor_total + valor;
        ELSE
            IF data IS NOT NULL THEN
                grava_vendas_liquida(data, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
            END IF;

            data             := nfs.data_emissao;
            cliente          := nfs.cod_cliente;
            agrupamento      := nfs.cod_agrupamento;
            subagrupamento   := nfs.sub_agrupamento;
            quantidade_total := quantidade;
            valor_total      := valor;

        END IF;

    END LOOP;

    IF data IS NOT NULL THEN
        grava_vendas_liquida(data, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
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
                        valor          IN bi0200.valor%TYPE) AS
 BEGIN

    INSERT INTO bi0200
         VALUES (bi0200_codigo.nextval,
                 data,
                 cliente,
                 agrupamento,
                 subagrupamento,
                 quantidade,
                 valor);

    COMMIT;

 END grava_cutoff;

 -----------------------------------------------
 -- Busca as NFs de cutoff e chama a gravacao --
 -----------------------------------------------
 PROCEDURE processa_nfs_cutoff(data IN DATE)

 IS

    cliente          bi0100.cliente%TYPE;
    agrupamento      bi0100.agrupamento%TYPE;
    subagrupamento   bi0100.subagrupamento%TYPE;
    quantidade_total bi0100.quantidade%TYPE;
    valor_total      bi0100.valor%TYPE;

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
               NVL(iat037.sub_agrupamento,'082') sub_agrupamento,
               iat177.cod_familia
          FROM cct059,
               cct058,
               iat066,
               iat037,
               iat177
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
                quantidade_total := quantidade_total + quantidade;
                valor_total      := valor_total + valor;
        ELSE
            IF cliente IS NOT NULL THEN
                grava_cutoff(cutoff, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
            END IF;

            cliente          := nfs.cod_cliente;
            agrupamento      := nfs.cod_agrupamento;
            subagrupamento   := nfs.sub_agrupamento;
            quantidade_total := quantidade;
            valor_total      := valor;

        END IF;

    END LOOP;

    IF cliente IS NOT NULL THEN
        grava_cutoff(cutoff, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
    END iF;

 END processa_nfs_cutoff;

 -----------------------------------------------------------------
 -- Busca as NFs de cutoff e chama a gravacao para cutoff anual --
 -----------------------------------------------------------------
 PROCEDURE processa_nfs_cutoff_anual(data IN DATE)

 IS

    cliente          bi0100.cliente%TYPE;
    agrupamento      bi0100.agrupamento%TYPE;
    subagrupamento   bi0100.subagrupamento%TYPE;
    quantidade_total bi0100.quantidade%TYPE;
    valor_total      bi0100.valor%TYPE;

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
               NVL(iat037.sub_agrupamento,'082') sub_agrupamento,
               iat177.cod_familia
          FROM cct059,
               cct058,
               iat066,
               iat037,
               iat177
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
                quantidade_total := quantidade_total + quantidade;
                valor_total      := valor_total + valor;
        ELSE
            IF cliente IS NOT NULL THEN
                grava_cutoff(cutoff, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
            END IF;

            cliente          := nfs.cod_cliente;
            agrupamento      := nfs.cod_agrupamento;
            subagrupamento   := nfs.sub_agrupamento;
            quantidade_total := quantidade;
            valor_total      := valor;

        END IF;

    END LOOP;

    IF cliente IS NOT NULL THEN
        grava_cutoff(cutoff, TO_NUMBER(cliente, '99999'), agrupamento, subagrupamento, quantidade_total, valor_total);
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
 BEGIN

    exclui_vendas_liquida(inicio, fim);
    processa_nfs(inicio, fim);
    abate_devolucao(inicio, fim);
    abate_nota_de_credito(inicio, fim);

 END vendas_liquida;
 
 -----------------------------------------------
 -- Chamada principal para processar o Cutoff --
 -----------------------------------------------
 PROCEDURE cutoff(data IN DATE)

 IS
 BEGIN

   exclui_cutoff(data);
    
   IF TO_CHAR(data, 'MM') = '01' then
       processa_nfs_cutoff_anual(data);
   ELSE
       processa_nfs_cutoff(data);   
   END IF;

 END cutoff;

END PACK_BI;