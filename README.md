# docker-test-ruby

## Buildando
docker build --build-arg LOCAL_REPO=<local_codigo_teste> -t diogocosta/automated-ruby .

## Rodando o container em backgraondnd
docker run -it -d -v <local_codigo_teste>:/automated diogocosta/automated-ruby features/

## Rodando com saida do console
docker run -it -v <local_codigo_teste>:/automated diogocosta/automated-ruby features/

## Para entrar no container
docker exec -it `ID` bash
