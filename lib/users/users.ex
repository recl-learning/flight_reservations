defmodule FlightReservations.Users.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys
  defstruct @keys

  def build(%{name: name, email: email, cpf: cpf}) do
    %__MODULE__{
      id: UUID.uuid4(),
      name: name,
      email: email,
      cpf: cpf
    }
  end
end
