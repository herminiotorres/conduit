defmodule Conduit.Accounts.Aggregates.User do
  @derive Jason.Encoder

  defstruct [:uuid, :username, :email, :hashed_password]

  alias __MODULE__
  alias Conduit.Accounts.Commands.RegisterUser
  alias Conduit.Accounts.Events.UserRegistered

  @doc """
  Register a new user
  """
  def execute(%User{uuid: nil}, %RegisterUser{} = command) do
    %UserRegistered{
      user_uuid: command.user_uuid,
      username: command.username,
      email: command.email,
      hashed_password: command.hashed_password
    }
  end

  # state mutators

  def apply(%User{} = user, %UserRegistered{} = event) do
    %User{
      user
      | uuid: event.user_uuid,
        username: event.username,
        email: event.email,
        hashed_password: event.hashed_password
    }
  end
end
