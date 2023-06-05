defmodule CityBikesBackWeb.StationController do
  use CityBikesBackWeb, :controller

  def index(conn, %{"country" => country, "network_id" => network_id}) do
    url = "http://api.citybik.es/v2/networks/#{network_id}"

    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        IO.inspect(body, label: "res")
        station_count = fetch_number_of_stations(body)

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, %{station_count: station_count})

      {:ok, %{status_code: status_code, body: body}} ->
        conn
        |> put_status(status_code)
        |> put_resp_content_type("application/json")
        |> send_resp(status_code, body)

      {:error, %{reason: reason}} ->
        conn
        |> put_status(500)
        |> put_resp_content_type("application/json")
        |> send_resp(500, reason)
    end
  end

  defp fetch_number_of_stations(body) do
    case Jason.decode(body) do
      {:ok, %{"network" => %{"stations" => stations}}} ->
        Enum.count(stations)

      _ ->
        nil
    end
  end
end
