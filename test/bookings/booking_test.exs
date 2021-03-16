defmodule FlightReservations.Bookings.BookingTest do
  use ExUnit.Case

  alias FlightReservations.Bookings.Booking
  alias FlightReservations.Users.User

  import FlightReservations.Factory

  describe "build/1" do
    test "should build a valid booking" do
      %User{id: user_id} = build(:user)

      returned =
        Booking.build(%{
          data_completa: NaiveDateTime.new(2021, 6, 6, 0, 0, 0),
          cidade_origem: "Recife",
          cidade_destino: "Belo Horizonte",
          id_usuario: user_id
        })

      expected = build(:booking, id_usuario: user_id, id: returned.id)
      assert returned == expected
    end
  end
end
