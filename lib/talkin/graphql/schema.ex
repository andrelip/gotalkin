defmodule Talkin.GraphQL.Schema do
  use Absinthe.Schema
  import_types Talkin.GraphQL.Schema.Types

  input_object :update_user_params do
    field :name, :string
    field :email, :string
    field :password, :string
  end

  query do
    field :users, list_of(:user) do
      resolve &Talkin.GraphQL.UserResolver.all/2
    end

    field :test_auth, :user do
      resolve &Talkin.GraphQL.UserResolver.all_mine/2
    end
  end

  mutation do
    field :update_user, type: :user do
      arg :id, non_null(:integer)
      arg :user, :update_user_params

      resolve &Talkin.GraphQL.UserResolver.update/2
    end

    field :login, type: :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &Talkin.GraphQL.UserResolver.login/2
    end
  end
end
