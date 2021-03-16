defmodule FlightReservations.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias FlightReservations.Users.{CreateOrUpdate, UserAgent}

  import FlightReservations.Factory

  describe "call/1" do
    setup do
      UserAgent.start_link()
      :ok
    end

    test "should create a valid user" do
      payload = %{
        name: "Ricardo",
        email: "ricardo@email.net",
        cpf: "12345678900"
      }

      {:ok, returned} = CreateOrUpdate.call(payload)
      expected = build(:user, id: returned.id)
      assert returned == expected
    end

    test "should return an error for an invalid user" do
      payload = %{
        name: "Ricardo",
        email: "ricardo@email.net",
        cpf: 12345678900
      }

      returned = CreateOrUpdate.call(payload)
      expected = {:error, "Invalid user."}
      assert returned == expected
    end
  end
end
