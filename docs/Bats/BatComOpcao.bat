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
Echo ���������������������������������������������������������������������������Ŀ
Echo �    �����������������������������������������������������������������ͻ    �
Echo �    �                                                                 �    �
Echo �    �                         O CARLOS EH GAY?                        �    �
Echo �    �                                                                 �    �
Echo �    �                  S (SIM) N (N�O)  F (FIM/SAIR)                  �    �
Echo �    �����������������������������������������������������������������ͼ    �
Echo �����������������������������������������������������������������������������
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
Echo   ���������������������������������������������������������������������������Ŀ
Echo   �    �����������������������������������������������������������������ͻ    �
Echo   �    �                                                                 �    �
Echo   �    �                            PARABENS!!!                          �    �
Echo   �    �                                                                 �    �
Echo   �    �                         RESPOSTA CORRETA                        �    �
Echo   �    �                                                                 �    �
Echo   �    �����������������������������������������������������������������ͼ    �
Echo   �����������������������������������������������������������������������������
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
Echo   ���������������������������������������������������������������������������Ŀ
Echo   �    �����������������������������������������������������������������ͻ    �
Echo   �    �                                                                 �    �
Echo   �    �                        RESPOSTA INCORRETA                       �    �
Echo   �    �                                                                 �    �
Echo   �    �                         TUh Eh BURRO EIN                        �    �
Echo   �    �                      TODOS SABEM QUE ELE Eh!                    �    �
Echo   �    �                                                                 �    �
Echo   �    �����������������������������������������������������������������ͼ    �
Echo   �����������������������������������������������������������������������������
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
Echo ������������������������������������������������������������������������������
Echo.
Echo.                           OBRIGADO POR UTILIZAR NOSSO SISTEMA
Echo.
Echo    � ������������������������ � [     ��      ] � ����������������������� �
Echo                                        -    
Echo.                                                                    C��$t�ano.
Echo ������������������������������������������������������������������������������
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
Echo.
CHOICE /C:�/T:�,5/N
cls