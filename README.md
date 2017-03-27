# Install (Mac OS X)

### Install Elixir/Erlang:

  * ```brew update```
  * ```brew install elixir```
  * For other systems -> http://elixir-lang.org/install.html#distributions

### Install Phoenix and dependencies:

  * Install [Hex](https://hex.pm/) ```mix local.hex```
  * ```mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez```
  * ```brew install node``` (node >= 5.0.0 is needed)
  * ```brew install postgresql```

### Simple initial setup for this application:

  * ```mix phoenix.new webgeeks_raffle```
  * ```cd webgeeks_raffle```
  * ```mix ecto.create``` (be sure to have your local postgres user and password handy)
  * ```mix phoenix.gen.html Submission submissions first_name:string last_name:string job_title:string twitter_handle:string email:string```
  * add ```resources "/submissions", SubmissionController``` in ```web/router.ex```. Here is an example of what needs to be done:
  ```
  defmodule HelloWorld.Router do
    use HelloWorld.Web, :router

    pipeline :browser do
      plug :accepts, ["html"]
      plug :fetch_session
      plug :fetch_flash
      plug :protect_from_forgery
      plug :put_secure_browser_headers
    end

    pipeline :api do
      plug :accepts, ["json"]
    end

    scope "/", HelloWorld do
      pipe_through :browser # Use the default browser stack

      resources "/submissions", SubmissionController
      get "/", PageController, :index
    end

    # Other scopes may use custom stacks.
    # scope "/api", HelloWorld do
    #   pipe_through :api
    # end
  end
```
  * ```mix ecto.migrate```
  * ```mix phoenix.server```
  * in your browser navigate to ```localhost:4000/submissions```

### Additional setup:

  * Add `coherence` and `extwitter` to `mix.exs`
    * https://github.com/smpallen99/coherence <- login and session handling
    * https://github.com/parroty/extwitter <- Twitter API interface
  * Deploy to Heroku (http://www.phoenixframework.org/docs/heroku)
    * Setup Heroku account (https://signup.heroku.com/?c=70130000001x9jEAAQ)
    * Install Heroku command line tool
    * Create new application
    * Add Phoenix build packs
    * Custom setup for app within Heroku

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
