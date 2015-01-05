defmodule OAuth2.Authorize do
  alias OAuth2.Manager

  def authorize_user(code), do:
    authorize_user(code, :default, %{})

  def authorize_user(code, strategy_atom, params) do
    case Manager.get_strategy(strategy_atom) do
      {:ok, strategy} ->
        strategy.__struct__.authorize_user(code, strategy, params)
      error -> error
    end
  end

end