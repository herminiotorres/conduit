defmodule Conduit.Accounts.Projections.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts_users" do
    field :image, :string
    field :username, :string
    field :email, :string
    field :hashed_password, :string
    field :bio, :string

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :hashed_password, :bio, :image])
    |> validate_required([:username, :email, :hashed_password, :bio, :image])
  end
end
