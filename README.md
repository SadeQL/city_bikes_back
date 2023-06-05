# CityBikesBack

PROJECT SET UP

# Install Elixir and Phoenix

## Elixir

- I recommande using asdf (<https://www.pluralsight.com/guides/installing-elixir-erlang-with-asdf>)

## Phoenix

- `mix local.hex`

## Run Docker

- `docker-compose up --build`

Please note that the docker will run the app and the database, while the APP is not working correctly now.
Once running the docker-compose, please STOP the app (city_bikes_back_app)

## Run locally the server

Once the db is running, you can now run this command `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Improvements

I didn't finish the project, either backend or frontend because I was struggling fetching relative data with an existant API.
I first wanted to spawn a process computing that, and in the end it seems more relevant to fetch directly from the api ENDPOINT.

If I had more time, I would totally complete the task, by sending the correct response on `/networks` and `/stations`.
Now, the project itself is not working.

My code has a lot of duplications and doesn't really follow the convention. I was gonna refactorize everything once it's finished, but I didn't get the chance to.

If I could start over, here are the steps I'm gonna do:

1/ Fetch the data directly via HTTPoison and transform it to the expected one.
2/ Create dedicated endpoints allowing the manipulation.
3/ Implement the frontend as long as the backend is functionnal.
4/ Add back unit tests.
5/ Refactorize
