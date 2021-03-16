defmodule FlightReservations.Users.UserAgentTest do
  use ExUnit.Case

  alias FlightReservations.Users.UserAgent

  import FlightReservations.Factory

  setup do
    UserAgent.start_link()
    :ok
  end

  describe "save/1" do
    test "should save a user" do
      user = build(:user)
      {:ok, returned} = UserAgent.save(user)
      assert returned == user
    end
  end

  describe "get/1" do
    test "should get a user" do
      user = build(:user)
      UserAgent.save(user)
      {:ok, returned} = UserAgent.get(user.id)
      assert returned == user
    end

    test "should return an error for unexisting user" do
      returned = UserAgent.get("not_a_user_id")
      expected = {:error, "User with id 'not_a_user_id' not found."}
      assert returned == expected
    end
  end

  describe "get_all/0" do
    test "should get all users" do
      user = build(:user)
      expected = %{user.id => user}
      UserAgent.save(user)
      returned = UserAgent.get_all()
      assert returned == expected
    end
  end
end
