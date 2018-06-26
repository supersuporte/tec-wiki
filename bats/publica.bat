@Echo On
echo ---------------------------------------
echo Publicando arquivos na producao via ANT
echo ---------------------------------------
Set Choice=
Set /p ano=Digite o ANO da solicitacao:
Set /p numero=Digite o NUMERO da solicitacao:

z:
cd \Programas\Versoes\%ano%\%numero%-%ano%
ant
