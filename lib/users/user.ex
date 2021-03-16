defmodule FlightReservations.Users.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys @keys
  defstruct @keys

  def build(%{name: name, email: email, cpf: cpf}) when is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       name: name,
       email: email,
       cpf: cpf
     }}
  end

  def build(_invalid), do: {:error, "Invalid user."}
end
