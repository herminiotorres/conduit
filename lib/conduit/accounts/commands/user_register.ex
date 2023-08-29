defmodule Conduit.Accounts.Commands.RegisterUser do
  @enforce_keys [:user_uuid]
  defstruct [
    :user_uuid,
    :username,
    :email,
    :password,
    :hashed_password
  ]

  use ExConstructor

  alias __MODULE__

  def assign_uuid(%RegisterUser{} = register_user, user_uuid) do
    %RegisterUser{register_user | user_uuid: user_uuid}
  end
end
