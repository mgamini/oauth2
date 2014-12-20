defmodule OAuth2.Strategy.Verified do
  alias OAuth2.Request
  alias OAuth2.Error

  defstruct client_id: nil,
    client_secret: nil,
    site: "",
    authorization_endpoint: "/oauth/authorize",
    token_endpoint: "/oauth/token",
    grant_type: "authorization_code",
    token_method: :post,
    params: %{},
    headers: %{},
    redirect_uri: "",
    discovery_params: %{},
    jwks_uri: "",
    jwks_keys: [],
    token_request_keys: [:client_id, :client_secret, :redirect_uri, :grant_type]

  def new(params, discovery) do
    case Request.get(discovery) do
      {:ok, response} ->
        {standard, extra} = Dict.split(response.body, keys())
        {:ok, struct(__MODULE__, Dict.merge(standard, params |> Dict.put(:discovery_params, extra)))}
      error -> error
    end
  end

  def authorize_user(code, strategy, params) do
    request = Dict.take(strategy |> Map.from_struct, strategy.token_request_keys)
      |> Dict.put(:code, code)

    case Request.post(token_url(strategy), request, [{"Content-Type","application/x-www-form-urlencoded"}], []) do
      {:ok, response}  ->
        IO.inspect response
        {:ok, AccessToken.new(response.body, strategy, [])}
      {:error, reason} -> {:error, %Error{reason: reason}}
    end
  end

  defp keys(), do:
    %__MODULE__{} |> Map.from_struct |> Dict.keys

  defp headers(strategy), do:
    [{"Content-Type", "application/x-www-form-urlencoded"} | strategy.headers]

  defp token_url(strategy) do
    base = strategy.token_endpoint

    if strategy.token_endpoint |> String.first == "/", do:
      base = strategy.site <> strategy.token_endpoint

    base <> "?"
  end


end

#       code: code,
#       grant_type: "authorization_code",
#       client_id: strategy.client_id,
#       client_secret: strategy.client_secret,
#       redirect_uri: strategy.redirect_uri

#   """
#   def to_url(strategy, endpoint) do
#     endpoint = Map.get(strategy, endpoint)
#     endpoint(strategy, endpoint) <> "?" <> URI.encode_query(strategy.params)
#   end

#   defp endpoint(strategy, <<"/"::utf8, _::binary>> = endpoint), do:
#     strategy.site <> endpoint
#   defp endpoint(_strategy, endpoint), do:
#     endpoint
#     """

# OAuth2.Manager.register {:google, %{client_id: "304882664537-98pq4eu60v18bloe507lems1ofg4ec1u.apps.googleusercontent.com", client_secret: "I3_Rlulaz4f056DjVIGuEhRh", redirect_uri: "http://localhost:4000/oauth"}, "https://accounts.google.com/.well-known/openid-configuration"}