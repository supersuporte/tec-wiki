@Echo off

:INICIO
cls
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo ÚÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄ¿
Echo ³    ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»    ³
Echo ³    º                                                                 º    ³
Echo ³    º                         ESCOLHA UMA OPCAO?                      º    ³
Echo ³    º                                                                 º    ³
Echo ³    º                  S (SIM) N (NÇO)  F (FIM/SAIR)                  º    ³
Echo ³    ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼    ³
Echo ÀÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÙ
Echo.
Echo.
Echo.
CHOICE /C:SNF > Nul
IF ERRORLEVEL 3 GOTO SAIR
IF ERRORLEVEL 2 GOTO NAO
IF ERRORLEVEL 1 GOTO SIM

:SIM
cls
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo   ÚÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄ¿
Echo   ³    ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»    ³
Echo   ³    º                                                                 º    ³
Echo   ³    º                            PARABENS!!!                          º    ³
Echo   ³    º                                                                 º    ³
Echo   ³    º                         RESPOSTA CORRETA                        º    ³
Echo   ³    º                                                                 º    ³
Echo   ³    ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼    ³
Echo   ÀÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÙ
Echo.
Echo                     PRESSIONE QUALQUER TECLA PARA CONTINUAR 
Echo.
Echo.
Echo.
Echo.
Echo.
PAUSE > Nul
GOTO INICIO

:NAO
cls
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo   ÚÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄ¿
Echo   ³    ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»    ³
Echo   ³    º                                                                 º    ³
Echo   ³    º                        RESPOSTA INCORRETA                       º    ³
Echo   ³    º                                                                 º    ³
Echo   ³    º                          TENTE NOVAMENTE                        º    ³
Echo   ³    º                                                                 º    ³
Echo   ³    º                                                                 º    ³
Echo   ³    ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼    ³
Echo   ÀÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÙ
Echo.
Echo                     PRESSIONE QUALQUER TECLA PARA CONTINUAR 
Echo.
Echo.
Echo.
Echo.
Echo.
PAUSE > Nul
GOTO INICIO

REM -------------------------   ( SAINDO)   -------------------------
:SAIR
CLS
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
Echo.
Echo.                           OBRIGADO POR UTILIZAR NOSSO SISTEMA
Echo.
Echo    ° °°°°°°°°°°°°°°°°°°°°°°°° ° [     â¨åª      ] ° °°°°°°°°°°°°°°°°°°°°°°° °
Echo                                        -    
Echo.                                                                    C©¡$t¡ano.
Echo ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
CHOICE /C:ÿ/T:ÿ,5/N
cls
