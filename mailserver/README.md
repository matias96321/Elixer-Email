# Envio de email
> Criando serviço de envio de email com elixir.

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

Este projeto visa pratica e refinar os conceitos da linguagem Elixir. 

![](../header.png)

## Criando o projeto

```sh
 $ mix new mailserver --sup
 $ CD mailserver
```

## Instalando dependências

Estas serão as dependências instaladas do projeto:

- ### [plug_cowboy][plug_cowboy] 
  * Uma implementação do Cowboy para o Elixir.
- ### [poison][poison]
  * Biblioteca JSON para o Elixir.
- ### [plug][plug]
  * Uma especificação para componentes e adaptadores web.
- ### [bamboo][bamboo]
  * Envio de e-mail com Elixir.
- ### [bamboo_smtp][bamboo_smtp]
  * Adaptador para usarmos SMTP no bamboo.

Abrindo o arquivo `mix.esx`, na raiz do projeto, adicionaremos as seguintes linhas no campo `deps`:

```sh
  {:plug, "~> 1.5"},
  {:plug_cowboy, "~> 1.0"},
  {:poison, "~> 3.1"},
  {:bamboo, "~> 2.1.0"},
  {:bamboo_smtp, "~> 4.0.1"}
```

Agora instalaremos as dependências definidas no arquivo `mix.esx` usando o comando:

```sh
$ mix deps.get
```


## Configurando o servidor HTTP

Sigamos para o arquivo `lib/mailserver/application.ex`, onde vamos estar configurando o nosso servidor HTTP, adiconando a seguinte linha no campo `children`:

```sh
  Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: Mailserver.Router, options: [port: 8085])
 ```


## Criando o modulo da rota
Crie um arquivo chamado `mail_routers.ex` na pasta `lib/mailserver` onde será definido o modulo responsavel pelas rotas da api

```sh
 defmodule Mailserver.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  import Bamboo.Email

plug(Plug.Logger, log: :debug)
plug(:match)
plug(:dispatch)

get "/" do
  new_email()
    |> to("meu@email.com")
    |> from("meu@email.com")
    |> subject("Teste")
    |> text_body("Testando envio de email")
    |> Mailserver.Mailer.deliver_now

    send_resp(conn, 200, "Server rodando...")
end

match _ do
  send_resp(conn, 404, "Pagina não encontrada")
end

end
```

Agora só basta iniciar o servidor com o comando e chamando a rota com o metodo GET e verificar o email do Mail Trap:

```sh
 $ iex -S mix
```


## Instalando o projeto 

Clone o repositório do projeto:

```sh
 $ git clone https://github.com/matias96321/Elixer-Email/tree/main/mailserver
```

Configurar servidor mtps em  `config/config.exs`

Instalar dependências: 

```sh
 $ mix deps.get
```

Iniciar projeto: 

```sh
 $ iex -S mix
```

acesse em:  http://localhost:8085/

## Meta

Matheus Souza Matias – [@Matheus](https://twitter.com/...) – mattheusmattias96@gmail.com

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

[https://github.com/matias96321](https://github.com/matias96321)

## Contributing

1. Faça o _fork_ do projeto (<https://github.com/yourname/yourproject/fork>)
2. Crie uma _branch_ para sua modificação (`git checkout -b feature/fooBar`)
3. Faça o _commit_ (`git commit -am 'Add some fooBar'`)
4. _Push_ (`git push origin feature/fooBar`)
5. Crie um novo _Pull Request_

[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[wiki]: https://github.com/seunome/seuprojeto/wiki
[plug_cowboy]: https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
[poison]: https://github.com/devinus/poison
[plug]: https://elixirschool.com/pt/lessons/misc/plug
[bamboo]: https://github.com/thoughtbot/bamboo
[bamboo]: https://github.com/thoughtbot/bamboo
[bamboo_smtp]: https://github.com/fewlinesco/bamboo_smtp

