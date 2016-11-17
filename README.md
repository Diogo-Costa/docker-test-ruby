# docker-test-ruby

## Buildando
docker build --build-arg LOCAL_REPO=<local_codigo_teste> -t diogocosta/eleanor .

## Rodando o container em background
docker run -it -d -v <local_codigo_teste>:/automated diogocosta/eleanor features

## Rodando com saida do console
docker run -it -v <local_codigo_teste>:/automated diogocosta/eleanor features
