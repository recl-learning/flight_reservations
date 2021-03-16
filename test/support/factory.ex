defmodule FlightReservations.Factory do
  use ExMachina

  alias FlightReservations.Users.User
  alias FlightReservations.Bookings.Booking

  def user_factory() do
    %User{
      id: UUID.uuid4(),
      name: "Ricardo",
      email: "ricardo@email.net",
      cpf: "12345678900"
    }
  end

  def booking_factory() do
    %Booking{
      id: UUID.uuid4(),
      data_completa: NaiveDateTime.new(2021, 6, 6, 0, 0, 0),
      cidade_origem: "Recife",
      cidade_destino: "Belo Horizonte",
      id_usuario: UUID.uuid4()
    }
  end
end
