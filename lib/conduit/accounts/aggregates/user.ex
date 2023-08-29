defmodule Conduit.Accounts.Aggregates.User do
  defstruct [:uuid, :username, :email, :hashed_password]

  @doc """
  Register a new user
  """
  def execute(%__MODULE__{uuid: nil}, %RegisterUser{} = register) do
    %UserRegistered{
      user_uuid: register.user_uuid,
      username: register.username,
      email: register.email,
      hashed_password: register.hashed_password
    }
  end

  # state mutators

  def apply(%__MODULE__{} = user, %UserRegistered{} = registered) do
    %__MODULE__{
      user
      | uuid: registered.user_uuid,
        username: registered.username,
        email: registered.email,
        hashed_password: registered.hashed_password
    }
  end
end
