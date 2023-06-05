defmodule CityBikesBackWeb.NetworkController do
  use CityBikesBackWeb, :controller

  def index(conn, params) do
    query_param = build_query_params(params)

    case HTTPoison.get("http://api.citybik.es/v2/networks" <> build_query_string(query_param)) do
      {:ok, %{status_code: 200, body: body}} ->
        conn
        |> put_status(200)
        |> put_resp_content_type("application/json")
        |> text(body)

      {:ok, %{status_code: status_code, body: body}} ->
        conn
        |> put_status(status_code)
        |> put_resp_content_type("application/json")
        |> text(body)

      {:error, reason} ->
        conn
        |> put_status(500)
        |> put_resp_content_type("application/json")
        |> text(reason)
    end
  end

  def create(conn, %{"network" => network_params}) do
    headers = [{"Content-Type", "application/json"}]
    body = Jason.encode!(network_params)

    case HTTPoison.post("http://api.citybik.es/v2/networks", body, headers) do
      {:ok, %{status_code: 201, body: body}} ->
        conn
        |> put_status(201)
        |> put_resp_content_type("application/json")
        |> json(body)

      {:ok, %{status_code: status_code, body: body}} ->
        conn
        |> put_status(status_code)
        |> put_resp_content_type("application/json")
        |> text(body)

      {:error, reason} ->
        conn
        |> put_status(500)
        |> put_resp_content_type("application/json")
        |> text(reason)
    end
  end

  defp build_query_params(params) do
    query_params = []

    case params["city"] do
      "" -> query_params
      city -> query_params ++ [{"location.city"}, city]
    end

    case params["name"] do
      "" -> query_params
      name -> query_params ++ [{"name", name}]
    end

    query_params
  end

  defp build_query_string(query_params) do
    case query_params do
      [] -> ""
      _ -> "?" <> URI.encode_query(query_params)
    end
  end
end
