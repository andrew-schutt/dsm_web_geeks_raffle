# Install (Mac OS X)

Install Elixir/Erlang:

  * ```brew update```
  * ```brew install elixir```
  * For other systems -> http://elixir-lang.org/install.html#distributions

Install Phoenix and dependencies:

  * Install [Hex](https://hex.pm/) ```mix local.hex```
  * ```mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez```
  * ```brew install node``` (node >= 5.0.0 is needed)
  * ```brew install postgresql```

Simple initial setup for this application:

  * ```mix phoenix.new webgeeks_raffle```
  * ```cd webgeeks_raffle```
  * ```mix phoenix.gen.html Submission submissions first_name:string last_name:string job_title:string twitter_handle:string email:string```
  * ```mix ecto.create``` (database configuration is needed before this step)
  * ```mix phoenix.server```


# WebgeeksRaffle

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
