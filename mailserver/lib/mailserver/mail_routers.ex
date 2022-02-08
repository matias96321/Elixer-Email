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
    |> to("matias_69914081@hotmail.com")
    |> from("i.e 56b779d1d9-e5d627+1@inbox.mailtrap.io")
    |> subject("Teste")
    |> text_body("Testando envio de email")
    |> Mailserver.Mailer.deliver_now

    send_resp(conn, 200, "Server rodando...")
end

match _ do
  send_resp(conn, 404, "Pagina não encontrada")
end

end
