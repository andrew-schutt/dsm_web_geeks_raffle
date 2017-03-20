# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WebgeeksRaffle.Repo.insert!(%WebgeeksRaffle.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

WebgeeksRaffle.Repo.delete_all WebgeeksRaffle.User

WebgeeksRaffle.User.changeset(%WebgeeksRaffle.User{}, %{name: "Admin User", email: "admin@example.com", password: "password", password_confirmation: "password"})
|> WebgeeksRaffle.Repo.insert!
