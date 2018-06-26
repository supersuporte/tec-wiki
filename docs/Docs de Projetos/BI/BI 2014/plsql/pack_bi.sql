create or replace 
PACKAGE PACK_BI IS

    PROCEDURE vendas_liquida(inicio IN DATE,
                             fim    IN DATE);

    PROCEDURE vendas_liquida_produto(inicio IN DATE,
                                     fim    IN DATE);

    PROCEDURE cutoff(data IN DATE);

    PROCEDURE cutoff_produto(data IN DATE);

    PROCEDURE atualiza_fechamento_mviews(nada VARCHAR2);
END PACK_BI;