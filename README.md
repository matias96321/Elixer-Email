# Envio de email

> Construindo um serviço de envio de email com Elixir..

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

Este projeto tem como objetivo criar um serviço de envio de email utilizando os conceitos da linguagem Elixir.

![](../header.png)

## Criando o Projeto

```sh
 $ mix new mailserver --sup
 $ CD mailserver
```

## Instalando Dependências

Estas são as dependências que serão instaladas no projeto:

- ### [plug_cowboy][plug_cowboy]
  - Uma implementação do Cowboy para o Elixir.
- ### [poison][poison]
  - Biblioteca JSON para o Elixir.
- ### [plug][plug]
  - Uma especificação para componentes e adaptadores web.
- ### [bamboo][bamboo]
  - Envio de e-mail com Elixir.
- ### [bamboo_smtp][bamboo_smtp]
  - Adaptador para usarmos SMTP no bamboo.

Abra o arquivo `mix.esx` na raiz do projeto e adicione as seguintes linhas ao campo `deps`:

```sh
  {:plug, "~> 1.5"},
  {:plug_cowboy, "~> 1.0"},
  {:poison, "~> 3.1"},
  {:bamboo, "~> 2.1.0"},
  {:bamboo_smtp, "~> 4.0.1"}
```

Agora, instale as dependências definidas no arquivo `mix.esx` usando o seguinte comando:

```sh
$ mix deps.get
```

## Configurando o Servidor HTTP

Sigamos para o arquivo `lib/mailserver/application.ex`, onde configuraremos nosso servidor HTTP adicionando a seguinte linha ao campo `children`:

```sh
  Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: Mailserver.Router, options: [port: 8085])
```

## Criando o Módulo de Rota

Crie um arquivo chamado `mail_routers.ex` na pasta `lib/mailserver`, onde definiremos o módulo responsável pelas rotas da API:

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

Agora, basta iniciar o servidor com o seguinte comando e acessar a rota usando o método GET para verificar o email no Mail Trap:

```sh
 $ iex -S mix
```

## Configurando o Projeto

Clone o repositório do projeto:

```sh
 $ git clone https://github.com/matias96321/Elixer-Email/tree/main/mailserver
```

Configure o servidor SMTP em `config/config.exs`

Instale as dependências:

```sh
 $ mix deps.get
```

Inicie o projeto:

```sh
 $ iex -S mix
```

Acesse em: http://localhost:8085/

## Meta

Matheus Souza Matias – [@Matheus](https://twitter.com/...) – mattheusmattias96@gmail.com

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

[https://github.com/matias96321](https://github.com/matias96321)

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
