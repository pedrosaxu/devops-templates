#!/bin/bash

# Interrompe a execução do script caso ocorra algum erro
set -e 

# Utiliza a ferramenta `jq` para processar uma entrada JSON que contém a chave `ip`.
# O resultado da expressão é uma atribuição de valor à variável `ip`.
#
# Também é possível coletar mais de uma variáveis utilizando o mesmo método, basta adicionar uma nova atribuição de valor
# separada por espaços em branco, como no exemplo abaixo que também coleta a variável `name`:
# eval "$(jq -r '@sh "ip=\(.ip) port=\(.port) name=\(.name)"')"
#
# Só não se esqueça de passar todas as variávies desejadas na query do DataSource.
eval "$(jq -r '@sh "ip=\(.ip)"')"

# Faz o script esperar por 300 segundos antes de continuar a execução para garantir
# que o custom_data com as configurações do WebServer tenham finalizado
sleep 300  

# Atribui o valor da variável `ip` coletada no eval à variável `IP`
IP="$ip"

# Faz uma requisição HTTP GET para o endereço IP armazenado na variável `IP`
# utilizando o comando `curl`. O resultado é armazenado na variável `RESULT`.
RESULT=$(curl $IP)

# Utiliza a ferramenta `jq` para criar um objeto JSON contendo as chaves `ip` e `result`.
# As opções `-n` e `--arg` são usadas para passar as variáveis `IP` e `RESULT` para dentro do objeto JSON.
jq -n --arg ip "$IP" --arg result "$RESULT" '{"ip":$ip, "result":$result}'


