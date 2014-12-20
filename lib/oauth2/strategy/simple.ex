defmodule OAuth2.Strategy.Simple do
  alias OAuth2.Request

  defstruct client_id: nil,
    client_secret: nil,
    site: "",
    authorization_endpoint: "/oauth/authorize",
    token_endpoint: "/oauth/token",
    token_method: :post,
    params: %{},
    headers: %{},
    redirect_uri: ""

  def new(params), do:
    {:ok, struct(__MODULE__, params)}
end

