defmodule AmazingChat.Repo do
  use Ecto.Repo,
    otp_app: :amazing_chat,
    adapter: Ecto.Adapters.Postgres
end
