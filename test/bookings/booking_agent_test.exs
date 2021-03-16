defmodule FlightReservations.Bookings.BookingAgentTest do
  use ExUnit.Case

  alias FlightReservations.Bookings.BookingAgent

  import FlightReservations.Factory

  setup do
    BookingAgent.start_link()
    :ok
  end

  describe "save/1" do
    test "should save a booking" do
      booking = build(:booking)
      {:ok, returned} = BookingAgent.save(booking)
      assert returned == booking
    end
  end

  describe "get/1" do
    test "should get a booking" do
      booking = build(:booking)
      BookingAgent.save(booking)
      {:ok, returned} = BookingAgent.get(booking.id)
      assert returned == booking
    end

    test "should return an error for unexisting booking" do
      returned = BookingAgent.get("not_a_booking_id")
      expected = {:error, "Booking with id 'not_a_booking_id' not found."}
      assert returned == expected
    end
  end

  describe "get_all/0" do
    test "should get all bookings" do
      booking = build(:booking)
      expected = %{booking.id => booking}
      BookingAgent.save(booking)
      returned = BookingAgent.get_all()
      assert returned == expected
    end
  end
end
