create or replace
PACKAGE BODY PACK_BI_OFF
IS

 PROCEDURE fechamento01 as
 begin

    PACK_BI.vendas_liquida('01/01/2014','31/12/2014');
    PACK_BI.vendas_liquida_produto('01/01/2014','31/12/2014');
 
    PACK_BI.cutoff('01/01/2014');
    PACK_BI.cutoff('01/02/2014');
    PACK_BI.cutoff('01/03/2014');
    PACK_BI.cutoff('01/04/2014');
    PACK_BI.cutoff('01/05/2014');
    PACK_BI.cutoff('01/06/2014');
    PACK_BI.cutoff('01/07/2014');
    PACK_BI.cutoff('01/08/2014');
    PACK_BI.cutoff('01/09/2014');
    PACK_BI.cutoff('01/10/2014');
    PACK_BI.cutoff('01/11/2014');
    PACK_BI.cutoff('01/12/2014');

    PACK_BI.cutoff_produto('01/01/2014');
    PACK_BI.cutoff_produto('01/02/2014');
    PACK_BI.cutoff_produto('01/03/2014');
    PACK_BI.cutoff_produto('01/04/2014');
    PACK_BI.cutoff_produto('01/05/2014');
    PACK_BI.cutoff_produto('01/06/2014');
    PACK_BI.cutoff_produto('01/07/2014');
    PACK_BI.cutoff_produto('01/08/2014');
    PACK_BI.cutoff_produto('01/09/2014');
    PACK_BI.cutoff_produto('01/10/2014');
    PACK_BI.cutoff_produto('01/11/2014');
    PACK_BI.cutoff_produto('01/12/2014');

    pack_bi_prazo_medio.prazo_medio_vendas(01,2014,12,2014);
    pack_bi_prazo_medio.prazo_medio_recebimento(01,2014,12,2014);

    pack_bi.atualiza_fechamento_mviews('');
 
 end fechamento01;


 PROCEDURE fechamento02 as
 begin

    PACK_BI.vendas_liquida('01/01/2013','31/12/2013');
    PACK_BI.vendas_liquida_produto('01/01/2013','31/12/2013');
 
    PACK_BI.cutoff('01/01/2013');
    PACK_BI.cutoff('01/02/2013');
    PACK_BI.cutoff('01/03/2013');
    PACK_BI.cutoff('01/04/2013');
    PACK_BI.cutoff('01/05/2013');
    PACK_BI.cutoff('01/06/2013');
    PACK_BI.cutoff('01/07/2013');
    PACK_BI.cutoff('01/08/2013');
    PACK_BI.cutoff('01/09/2013');
    PACK_BI.cutoff('01/10/2013');
    PACK_BI.cutoff('01/11/2013');
    PACK_BI.cutoff('01/12/2013');

    PACK_BI.cutoff_produto('01/01/2013');
    PACK_BI.cutoff_produto('01/02/2013');
    PACK_BI.cutoff_produto('01/03/2013');
    PACK_BI.cutoff_produto('01/04/2013');
    PACK_BI.cutoff_produto('01/05/2013');
    PACK_BI.cutoff_produto('01/06/2013');
    PACK_BI.cutoff_produto('01/07/2013');
    PACK_BI.cutoff_produto('01/08/2013');
    PACK_BI.cutoff_produto('01/09/2013');
    PACK_BI.cutoff_produto('01/10/2013');
    PACK_BI.cutoff_produto('01/11/2013');
    PACK_BI.cutoff_produto('01/12/2013');

    pack_bi_prazo_medio.prazo_medio_vendas(01,2013,12,2013);
    pack_bi_prazo_medio.prazo_medio_recebimento(01,2013,12,2013);

    pack_bi.atualiza_fechamento_mviews('');
 
 end fechamento02;
 
 PROCEDURE atualiza_familias as
 begin

-- executou em 20s
update cbt1397 set cod_familia = 'MS' where cod_familia = 'LZ'; -- 45k linhas
update cbt1397 set cod_familia = 'EC' where cod_familia = 'OP'; -- 37k linhas
update cbt1397 set cod_familia = 'OM' where cod_familia = 'XX'; -- 500 linhas

-- executou em 2s
update cbt1396 set cod_familia = 'MS' where cod_familia = 'LZ'; -- 6k linhas
update cbt1396 set cod_familia = 'EC' where cod_familia = 'OP'; -- 6k linhas
update cbt1396 set cod_familia = 'OM' where cod_familia = 'XX'; -- 100 linhas

-- executou em 1s
update iat177 set cod_familia = 'MS' where cod_familia = 'LZ'; -- 40 linhas
update iat177 set cod_familia = 'EC' where cod_familia = 'OP'; -- 10 linhas
update iat177 set cod_familia = 'OM' where cod_familia = 'XX'; -- 30 linhas

update iat084 set cod_familia = 'MS' where cod_familia = 'LZ';
update iat084 set cod_familia = 'EC' where cod_familia = 'OP';
update iat084 set cod_familia = 'OM' where cod_familia = 'XX';

commit;

update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 1999;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2000;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2001;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2002;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2003;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2004;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2005;
commit;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2006;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2007;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2008;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2009;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2010;
commit;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2011;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2012;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2013;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2014;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2015;
update cct087 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2016;
commit;

update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 1999;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2000;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2001;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2002;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2003;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2004;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2005;
commit;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2006;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2007;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2008;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2009;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2010;
commit;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2011;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2012;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2013;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2014;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2015;
update cct087 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2016;
commit;

update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 1999;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2000;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2001;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2002;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2003;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2004;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2005;
commit;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2006;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2007;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2008;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2009;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2010;
commit;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2011;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2012;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2013;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2014;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2015;
update cct087 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2016;
commit;

update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2010;
update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2011;
update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2012;
commit;
update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2013;
update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2014;
update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2015;
update cut052 set cod_familia = 'MS' where cod_familia = 'LZ' and ano = 2016;
commit;

update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2010;
update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2011;
update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2012;
commit;
update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2013;
update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2014;
update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2015;
update cut052 set cod_familia = 'EC' where cod_familia = 'OP' and ano = 2016;
commit;

update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2010;
update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2011;
update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2012;
update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2013;
update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2014;
update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2015;
update cut052 set cod_familia = 'OM' where cod_familia = 'XX' and ano = 2016;
commit;

pack_bi.atualiza_fechamento_mviews('');
 
 end atualiza_familias;
 
 PROCEDURE fechamento_periodo as
 begin

    PACK_BI.vendas_liquida('01/04/2016','30/04/2016');
    PACK_BI.vendas_liquida_produto('01/04/2016','30/04/2016');
 
    PACK_BI.cutoff('01/04/2016');
    PACK_BI.cutoff_produto('01/04/2016');
    PACK_BI.cutoff('01/05/2016');
    PACK_BI.cutoff_produto('01/05/2016');

    pack_bi_prazo_medio.prazo_medio_vendas(04,2016,04,2016);
    pack_bi_prazo_medio.prazo_medio_recebimento(04,2016,04,2016);

    pack_bi.atualiza_fechamento_mviews('');
 
 end fechamento_periodo;

END PACK_BI_OFF;