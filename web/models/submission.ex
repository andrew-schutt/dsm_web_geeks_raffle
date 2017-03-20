defmodule WebgeeksRaffle.Submission do
  use WebgeeksRaffle.Web, :model

  schema "submissions" do
    field :first_name, :string
    field :last_name, :string
    field :job_title, :string
    field :twitter_handle, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :job_title, :twitter_handle, :email])
    |> validate_required([:first_name, :last_name, :job_title, :twitter_handle])
    |> unique_constraint([:email, :twitter_handle])
  end
end
