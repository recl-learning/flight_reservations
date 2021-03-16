defmodule FlightReservationsTest do
  use ExUnit.Case

  import FlightReservations.Factory

  setup do
    FlightReservations.start_agents()
    :ok
  end

  describe "create_user/1" do
    test "should create user" do
      {:ok, returned} =
        FlightReservations.create_user(%{
          name: "Ricardo",
          email: "ricardo@email.net",
          cpf: "12345678900"
        })

      expected = build(:user, id: returned.id)
      assert returned == expected
    end
  end

  describe "get_user/1" do
    test "should get user" do
      {:ok, user} =
        FlightReservations.create_user(%{
          name: "Ricardo",
          email: "ricardo@email.net",
          cpf: "12345678900"
        })

      {:ok, returned} = FlightReservations.get_user(user.id)

      expected = build(:user, id: returned.id)
      assert returned == expected
    end
  end

  describe "create_booking/2" do
    test "should create booking given existing user id" do
      {:ok, user} =
        FlightReservations.create_user(%{
          name: "Ricardo",
          email: "ricardo@email.net",
          cpf: "12345678900"
        })

      params = %{
        data_completa: NaiveDateTime.new(2021, 6, 6, 0, 0, 0),
        cidade_origem: "Recife",
        cidade_destino: "Belo Horizonte",
        id_usuario: user.id
      }

      {:ok, returned} = FlightReservations.create_booking(user.id, params)
      expected = build(:booking, id: returned.id, id_usuario: user.id)
      assert returned == expected
    end
  end

  describe "get_booking/1" do
    test "should get booking" do
      {:ok, user} =
        FlightReservations.create_user(%{
          name: "Ricardo",
          email: "ricardo@email.net",
          cpf: "12345678900"
        })

      params = %{
        data_completa: NaiveDateTime.new(2021, 6, 6, 0, 0, 0),
        cidade_origem: "Recife",
        cidade_destino: "Belo Horizonte",
        id_usuario: user.id
      }

      {:ok, booking} = FlightReservations.create_booking(user.id, params)

      {:ok, returned} = FlightReservations.get_booking(booking.id)

      expected = build(:booking, id: returned.id, id_usuario: user.id)

      assert returned == expected
    end
  end
end
