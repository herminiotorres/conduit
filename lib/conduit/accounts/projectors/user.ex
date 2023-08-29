defmodule Conduit.Accounts.Projectors.User do
  use Commanded.Projections.Ecto,
    name: "Accounts.Projectors.User",
    application: Conduit.App,
    consistency: :strong

  alias Conduit.Accounts.Events.UserRegistered
  alias Conduit.Accounts.Projections.User

  project(%UserRegistered{} = registered, fn multi ->
    Ecto.Multi.insert(multi, :user, %User{
      uuid: registered.user_uuid,
      username: registered.username,
      email: registered.email,
      hashed_password: registered.hashed_password
    })
  end)
end
