call pack_bi.vendas_liquida('01/01/2014','31/12/2015');
call pack_bi.vendas_liquida_produto('01/01/2014','31/12/2015');

call pack_bi.cutoff('01/01/2014');
call pack_bi.cutoff('01/02/2014');
call pack_bi.cutoff('01/03/2014');
call pack_bi.cutoff('01/04/2014');
call pack_bi.cutoff('01/05/2014');
call pack_bi.cutoff('01/06/2014');
call pack_bi.cutoff('01/07/2014');
call pack_bi.cutoff('01/08/2014');
call pack_bi.cutoff('01/09/2014');
call pack_bi.cutoff('01/10/2014');
call pack_bi.cutoff('01/11/2014');
call pack_bi.cutoff('01/12/2014');

call pack_bi.cutoff('01/01/2015');
call pack_bi.cutoff('01/02/2015');
call pack_bi.cutoff('01/03/2015');
call pack_bi.cutoff('01/04/2015');
call pack_bi.cutoff('01/05/2015');
call pack_bi.cutoff('01/06/2015');
call pack_bi.cutoff('01/07/2015');
call pack_bi.cutoff('01/08/2015');


call pack_bi.cutoff_produto('01/01/2014');
call pack_bi.cutoff_produto('01/02/2014');
call pack_bi.cutoff_produto('01/03/2014');
call pack_bi.cutoff_produto('01/04/2014');
call pack_bi.cutoff_produto('01/05/2014');
call pack_bi.cutoff_produto('01/06/2014');
call pack_bi.cutoff_produto('01/07/2014');
call pack_bi.cutoff_produto('01/08/2014');
call pack_bi.cutoff_produto('01/09/2014');
call pack_bi.cutoff_produto('01/10/2014');
call pack_bi.cutoff_produto('01/11/2014');
call pack_bi.cutoff_produto('01/12/2014');

call pack_bi.cutoff_produto('01/01/2015');
call pack_bi.cutoff_produto('01/02/2015');
call pack_bi.cutoff_produto('01/03/2015');
call pack_bi.cutoff_produto('01/04/2015');
call pack_bi.cutoff_produto('01/05/2015');
call pack_bi.cutoff_produto('01/06/2015');
call pack_bi.cutoff_produto('01/07/2015');
call pack_bi.cutoff_produto('01/08/2015');


call DBMS_MVIEW.REFRESH('BIV101');
call DBMS_MVIEW.REFRESH('BIV103');