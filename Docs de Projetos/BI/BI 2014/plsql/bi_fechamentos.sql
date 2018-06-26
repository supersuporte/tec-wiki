---------------------- PARTE 1 - MAIS LEVE --------------------------
call PACK_BI.vendas_liquida('01/01/2014','31/12/2014');
call PACK_BI.vendas_liquida_produto('01/01/2014','31/12/2014');
call PACK_BI.cutoff('01/01/2014');
call PACK_BI.cutoff('01/02/2014');
call PACK_BI.cutoff('01/03/2014');
call PACK_BI.cutoff('01/04/2014');
call PACK_BI.cutoff('01/05/2014');
call PACK_BI.cutoff('01/06/2014');
call PACK_BI.cutoff('01/07/2014');
call PACK_BI.cutoff('01/08/2014');
call PACK_BI.cutoff('01/09/2014');
call PACK_BI.cutoff('01/10/2014');
call PACK_BI.cutoff('01/11/2014');
call PACK_BI.cutoff('01/12/2014');
call PACK_BI.cutoff_produto('01/01/2014');
call PACK_BI.cutoff_produto('01/02/2014');
call PACK_BI.cutoff_produto('01/03/2014');
call PACK_BI.cutoff_produto('01/04/2014');
call PACK_BI.cutoff_produto('01/05/2014');
call PACK_BI.cutoff_produto('01/06/2014');
call PACK_BI.cutoff_produto('01/07/2014');
call PACK_BI.cutoff_produto('01/08/2014');
call PACK_BI.cutoff_produto('01/09/2014');
call PACK_BI.cutoff_produto('01/10/2014');
call PACK_BI.cutoff_produto('01/11/2014');
call PACK_BI.cutoff_produto('01/12/2014');

call pack_bi_prazo_medio.prazo_medio_vendas(01,2014,12,2014);
call pack_bi_prazo_medio.prazo_medio_recebimento(01,2014,12,2014);

call DBMS_MVIEW.REFRESH('BIV101');
call DBMS_MVIEW.REFRESH('BIV103');