::
:: renomeia.bat
:: ===========
::
:: Uso:
:: renomeia nome_do_arquivo string_para_remover string_para_adicionar
:: Ex.: renomeia *.dat br BR (transforma para maiusculo)

@ECHO OFF

SETLOCAL

SET ARQUIVOS=br_*.dat
SET REMOVESTR=br_auto_service_level_detail_
SET ADICIONASTR=BR_AUTO_SERVICE_LEVEL_DETAIL_

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
