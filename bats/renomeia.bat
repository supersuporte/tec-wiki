::
:: renomeia.bat
:: ===========
::
:: Uso:
:: renomeia nome_do_arquivo string_para_remover string_para_adicionar
:: Ex.: renomeia *.dat br BR (transforma para maiusculo)

@ECHO OFF

SETLOCAL

SET ARQUIVOS=%1
SET REMOVESTR=%2
SET ADICIONASTR=%3

FOR %%F IN (%ARQUIVOS%) DO CALL:funcRENOMEIA "%%F",%REMOVESTR%,%ADICIONASTR%

ENDLOCAL

GOTO :EOF


:funcRENOMEIA

SETLOCAL

SET ARQUIVO=%~1
SET REMSTR=%~2
SET ADDSTR=%~3

CALL SET NOVOARQUIVO=%%ARQUIVO:%REMSTR%=%ADDSTR%%%

RENAME "%ARQUIVO%" "%NOVOARQUIVO%"

ENDLOCAL
