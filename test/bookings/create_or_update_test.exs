defmodule FlightReservations.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  alias FlightReservations.Bookings.{CreateOrUpdate, BookingAgent}

  import FlightReservations.Factory

  describe "call/1" do
    setup do
      BookingAgent.start_link()
      :ok
    end

    test "should create a valid booking" do
      user_id = UUID.uuid4()
      payload = %{
        data_completa: NaiveDateTime.new!(2021, 6, 6, 0, 0, 0),
        cidade_origem: "Recife",
        cidade_destino: "Belo Horizonte",
        id_usuario: user_id
      }

      {:ok, returned} = CreateOrUpdate.call(user_id, payload)
      expected = build(:booking, id: returned.id, id_usuario: user_id)
      assert returned == expected
    end

    test "should return an error for an invalid booking" do
      payload = %{
        data_completa: NaiveDateTime.new!(2021, 6, 6, 0, 0, 0),
        cidade_origem: "Recife",
        cidade_destino: "Belo Horizonte",
        id_usuario: nil
      }

      returned = CreateOrUpdate.call(nil, payload)
      expected = {:error, "Invalid Booking."}
      assert returned == expected
    end
  end
end
