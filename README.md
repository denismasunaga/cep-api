# README

Cep-api é um sistema do tipo API only para consulta de Ceps.

## Instruções
Siga as instruções a seguir para rodar o ambiente localmente:

#### Pré-requisitos:
* ruby 2.7.3
* bundler
* mysql-server
* redis-server

#### Instalação:
Primeiro, faça o clone do repositório:

```shell
$ git clone https://github.com/denismasunaga/cep-api.git
```

Depois acesse o repositório e instale as dependências:

```shell
$ cd cep-api
$ bundle install
```

Então podemos criar o banco e o primeiro usuário:

```shell
$ bundle exec rails db:create db:migrate db:seed
```

Feito isso, basta iniciar o Sidekiq e a aplicação em si:

```shell
$ bundle exec sidekiq
$ bundle exec rails s
```

Ps.: A partir da versão 6 do Sidekiq, não é mais possível executá-lo como daemon somente com a flag -d. Por motivos de simplicidade, basta executá-lo em um terminal a parte, diferente do que estará executando o servidor rails ou então usar o comando abaixo:

```shell
$ bundle exec sidekiq & rails s
```

Note que neste caso, após a execução do comando, será necessário matar o processo do sidekiq manualmente, uma vez que o comando ctrl + c irá parar somente o rails s.