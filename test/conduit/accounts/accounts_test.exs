defmodule Conduit.AccountsTest do
  use Conduit.DataCase

  import Conduit.Factory

  alias Conduit.Accounts
  alias Conduit.Accounts.Projections.User

  defp fixture(:user, attrs \\ []) do
    build(:user, attrs) |> Accounts.create_user()
  end

  describe "users" do
    alias Conduit.Accounts.Projections.User

    @invalid_attrs %{image: nil, username: nil, email: nil, hashed_password: nil, bio: nil}

    test "list_users/0 returns all users" do
      {:ok, user} = fixture(:user)
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      {:ok, user} = fixture(:user)
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        image: "some image",
        username: "some username",
        email: "some email",
        hashed_password: "some hashed_password",
        bio: "some bio"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.image == "some image"
      assert user.username == "some username"
      assert user.email == "some email"
      assert user.hashed_password == "some hashed_password"
      assert user.bio == "some bio"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      {:ok, user} = fixture(:user)

      update_attrs = %{
        image: "some updated image",
        username: "some updated username",
        email: "some updated email",
        hashed_password: "some updated hashed_password",
        bio: "some updated bio"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.image == "some updated image"
      assert user.username == "some updated username"
      assert user.email == "some updated email"
      assert user.hashed_password == "some updated hashed_password"
      assert user.bio == "some updated bio"
    end

    test "update_user/2 with invalid data returns error changeset" do
      {:ok, user} = fixture(:user)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      {:ok, user} = fixture(:user)
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      {:ok, user} = fixture(:user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "register user" do
    @tag :integration
    test "should succeed with valid data" do
      assert {:ok, %User{} = user} = Accounts.register_user(build(:user))

      assert user.bio == "some bio"
      assert user.email == "some email"
      assert user.hashed_password == "some hashed_password"
      assert user.image == "some image"
      assert user.username == "some username"
    end

    @tag :integration
    test "should fail with invalid data and return error" do
      assert {:error, :validation_failure, errors} =
               Accounts.register_user(build(:user, username: ""))

      assert errors == %{username: ["can't be empty"]}
    end
  end
end
