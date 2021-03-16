defmodule FlightReservations.Factory do
  use ExMachina

  alias FlightReservations.Users.User

  def user_factory() do
    %User{
      id: UUID.uuid4(),
      name: "Ricardo",
      email: "ricardo@email.net",
      cpf: "12345678900"
    }
  end
end
