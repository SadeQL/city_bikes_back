

# Base image
FROM elixir:1.14.0 AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y build-essential

RUN apt-get update && apt-get install -y postgresql-client
# Set environment variables
ENV MIX_ENV=dev \
  APP_NAME=socials \
  DATABASE_URL=${DATABASE_URL}

# Create and set the working directory
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && mix local.rebar --force

# Copy the necessary files
COPY . .

# Fetch and compile dependencies
RUN mix deps.get
RUN mix deps.compile

# Compile the project
RUN mix compile


# Final image
FROM elixir:1.14.0 AS app


# Set environment variables
ENV MIX_ENV=dev \
  APP_NAME=my_app \
  DATABASE_URL=ecto://postgres:postgres@db/postgres

# Install inotify-tools
RUN apt-get update && apt-get install -y inotify-tools

# Copy the release from the builder stage
COPY --from=builder /app /app

# Set the working directory
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && mix local.rebar --force
# Expose the Phoenix server port
EXPOSE 4000

# Start the Phoenix server
CMD ["mix", "phx.server"]
