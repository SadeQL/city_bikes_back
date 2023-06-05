defmodule CityBikesBack.Repo do
  use Ecto.Repo,
    otp_app: :city_bikes_back,
    adapter: Ecto.Adapters.Postgres
end
