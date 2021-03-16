defmodule FlightReservations do
  alias FlightReservations.Bookings.CreateOrUpdate, as: CreateOrUpdateBooking
  alias FlightReservations.Bookings.BookingAgent
  alias FlightReservations.Users.CreateOrUpdate, as: CreateOrUpdateUser
  alias FlightReservations.Users.UserAgent

  def start_agents do
    BookingAgent.start_link()
    UserAgent.start_link()
  end

  def create_booking(user_id, params) do
    case get_user(user_id) do
      {:ok, _user} -> CreateOrUpdateBooking.call(user_id, params)
      {:error, _reason} = error -> error
    end
  end

  def get_booking(booking_id), do: BookingAgent.get(booking_id)
  def create_user(params), do: CreateOrUpdateUser.call(params)

  def get_user(user_id), do: UserAgent.get(user_id)
end
