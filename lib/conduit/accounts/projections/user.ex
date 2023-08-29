defmodule Conduit.Accounts.Projections.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Phoenix.Param, key: :uuid}
  @primary_key {:uuid, :binary_id, autogenerate: false}
  schema "accounts_users" do
    field :username, :string
    field :email, :string
    field :image, :string
    field :bio, :string
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :hashed_password, :bio, :image])
    |> validate_required([:username, :email, :hashed_password])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
