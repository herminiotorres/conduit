defmodule ConduitWeb.UserControllerTest do
  use ConduitWeb.ConnCase

  import Conduit.Factory

  alias Conduit.Accounts

  defp fixture(:user, attrs \\ []) do
    build(:user, attrs) |> Accounts.create_user()
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "register user" do
    @tag :web
    test "should create and return user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: build(:user))
      json = json_response(conn, 201)["data"]

      assert %{
               "bio" => "I like to skateboard",
               "email" => "jake@jake.jake",
               "hashed_password" => "jakejake",
               "image" => "https://i.stack.imgur.com/xHWG8.jpg",
               "username" => "jake"
             } = json
    end

    @tag :web
    test "should not create user and render errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: build(:user, username: ""))

      assert json_response(conn, 422)["errors"] == %{
               "username" => [
                 "can't be blank"
               ]
             }
    end

    @tag :web
    test "should not create user and render errors when username has been taken", %{conn: conn} do
      # register a user
      {:ok, _user} = fixture(:user)

      # attempt to register the same username
      conn = post(conn, ~p"/api/users", user: build(:user, email: "jake2@jake.jake"))

      json = json_response(conn, 422)

      assert json == %{
               "username" => [
                 "has already been taken"
               ]
             }
    end
  end
end
