defmodule Conduit.Repo.Migrations.ChangeAccountsUser do
  use Ecto.Migration

  def up do
    drop_if_exists table(:accounts_users)

    create_if_not_exists table(:accounts_users, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :username, :string
      add :email, :string
      add :hashed_password, :string
      add :bio, :string
      add :image, :string

      timestamps()
    end

    create_if_not_exists unique_index(:accounts_users, [:username])
    create_if_not_exists unique_index(:accounts_users, [:email])
  end

  def down do
    drop_if_exists index(:accounts_users, [:email])
    drop_if_exists index(:accounts_users, [:username])
    drop_if_exists table(:accounts_users)

    create_if_not_exists table(:accounts_users) do
      add :username, :string
      add :email, :string
      add :hashed_password, :string
      add :bio, :string
      add :image, :string

      timestamps()
    end
  end
end
