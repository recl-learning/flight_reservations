defmodule FlightReservations.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys @keys
  defstruct @keys

  def build(%{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        id_usuario: id_usuario
      }) when is_bitstring(id_usuario) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       data_completa: data_completa,
       cidade_origem: cidade_origem,
       cidade_destino: cidade_destino,
       id_usuario: id_usuario
     }}
  end
  def build(_invalid), do: {:error, "Invalid Booking."}

end
