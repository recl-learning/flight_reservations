defmodule FlightReservations.Users.UserTest do
  use ExUnit.Case

  alias FlightReservations.Users.User

  import FlightReservations.Factory

  describe "build/1" do
    test "should build a valid user" do
      returned =
        User.build(%{
          name: "Ricardo",
          email: "ricardo@email.net",
          cpf: "12345678900"
        })

      expected = build(:user, id: returned.id)
      assert returned == expected
    end
  end
end
