defmodule Conduit.Accounts.Aggregates.User do
  defstruct [:uuid, :username, :email, :hashed_password]

  alias Conduit.Accounts.Commands, as: C
  alias Conduit.Accounts.Events, as: E

  @doc """
  Register a new user
  """
  def execute(%__MODULE__{uuid: nil}, %C.RegisterUser{} = register) do
    %E.UserRegistered{
      user_uuid: register.user_uuid,
      username: register.username,
      email: register.email,
      hashed_password: register.hashed_password
    }
  end

  # state mutators

  def apply(%__MODULE__{} = user, %E.UserRegistered{} = registered) do
    %__MODULE__{
      user
      | uuid: registered.user_uuid,
        username: registered.username,
        email: registered.email,
        hashed_password: registered.hashed_password
    }
  end
end
