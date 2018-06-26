call pack_bi.vendas_liquida('01/01/2020', '01/01/2020');
call pack_bi.vendas_liquida_produto('01/01/2020', '01/01/2020');

call pack_bi.cutoff('01/01/2020');
call pack_bi.cutoff_produto('01/01/2020');

call pack_bi_prazo_medio.prazo_medio_vendas(01,2013,12,2013);
call pack_bi_prazo_medio.prazo_medio_recebimento(01,2013,12,2013);

call pack_bi.atualiza_fechamento_mviews('');
