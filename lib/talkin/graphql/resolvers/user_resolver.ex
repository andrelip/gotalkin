defmodule Talkin.GraphQL.UserResolver do
  alias Talkin.Accounts

  def update(%{id: id, user: user_params}, _info) do
    user = Accounts.get_user!(id)
    Accounts.update_user(user, user_params)
  end

  def all(_args, _info) do
    {:ok, Accounts.list_users()}
  end
end
