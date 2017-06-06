defmodule Talkin.GraphQL.UserResolver do
  alias Talkin.Accounts

  def update(%{id: id, user: user_params}, _info) do
    user = Accounts.get_user!(id)
    Accounts.update_user(user, user_params)
  end

  def all(_args, _info) do
    {:ok, Accounts.list_users()}
  end

  def login(params, _info) do
    with {:ok, user} <- Accounts.authenticate(params),
         {:ok, jwt, _ } <- Guardian.encode_and_sign(user, :access) do
      {:ok, %{token: jwt}}
    end
  end

  def all_mine(_args, %{context: %{current_user: %{id: id}}}) do
    {:ok, %{id: id}}
  end
end
