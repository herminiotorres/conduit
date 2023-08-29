defmodule ConduitWeb.UserJSON do
  alias Conduit.Accounts.Projections.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.uuid,
      username: user.username,
      email: user.email,
      hashed_password: user.hashed_password,
      bio: user.bio,
      image: user.image
    }
  end
end
