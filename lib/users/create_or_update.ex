defmodule FlightReservations.Users.CreateOrUpdate do
  alias FlightReservations.Users.{UserAgent, User}

  def call(%{} = payload) do
    payload
    |> User.build()
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}), do: UserAgent.save(user)
  defp save_user({:error, _reason} = error), do: error
end
