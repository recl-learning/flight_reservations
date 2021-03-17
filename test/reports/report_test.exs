defmodule FlightReservations.Reports.ReportTest do
  use ExUnit.Case

  import FlightReservations.Factory

  alias FlightReservations.Reports.Report, as: BookingReport
  alias FlightReservations.Users.User

  setup do
    FlightReservations.start_agents()

    {:ok, %User{id: user_id1}} = FlightReservations.create_user(build(:user))
    {:ok, %User{id: user_id2}} = FlightReservations.create_user(build(:user))

    booking1 =
      build(:booking,
        id_usuario: user_id1,
        data_completa: NaiveDateTime.new!(2021, 3, 22, 19, 29, 25),
        cidade_origem: "Vitória",
        cidade_destino: "Salvador"
      )

    booking2 =
      build(:booking,
        id_usuario: user_id2,
        data_completa: NaiveDateTime.new!(2021, 3, 14, 12, 12, 25),
        cidade_origem: "São Paulo",
        cidade_destino: "Rio de Janeiro"
      )

    booking3 =
      build(:booking,
        id_usuario: user_id1,
        data_completa: NaiveDateTime.new!(2021, 4, 18, 8, 45, 25),
        cidade_origem: "São Paulo",
        cidade_destino: "Londres"
      )

    FlightReservations.create_booking(user_id1, booking1)
    FlightReservations.create_booking(user_id2, booking2)
    FlightReservations.create_booking(user_id1, booking3)

    :ok
  end

  describe "create_report/0" do
    test "should save a report with all bookings" do
      BookingReport.create_report()
      {:ok, returned} = File.read("./reports/report.csv")

      size =
        returned
        |> String.trim()
        |> String.split("\n")
        |> Enum.count()

      expected = 3
      assert size == expected
    end
  end
end
