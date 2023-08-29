defmodule Conduit.Router do
  use Commanded.Commands.Router

  alias Conduit.Accounts.Aggregates.User
  alias Conduit.Accounts.Commands.RegisterUser

  identify(User, by: :user_uuid)

  dispatch(RegisterUser, to: User)
end
