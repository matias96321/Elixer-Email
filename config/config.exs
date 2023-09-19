use Mix.Config

config :mailserver, Mailserver.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "SERVER",
  hostname: "SERVER",
  port: 2525,
  username: "USER", # or {:system, "SMTP_USERNAME"}
  password: "PASS", # or {:system, "SMTP_PASSWORD"}
  tls: :always, # can be `:always` or `:never`
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {:system, "ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: false, # can be `true`
  retries: 1,
  no_mx_lookups: false, # can be `true`
  auth: :if_available # can be `:always`. If your smtp relay requires authentication set it to `:always`.
