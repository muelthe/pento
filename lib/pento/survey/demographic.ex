defmodule Pento.Survey.Demographic do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pento.Accounts.User

  schema "demographics" do
    field :gender, :string
    field :year_of_birth, :integer
    field :level_of_education, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(demographic, attrs) do
    demographic
    |> cast(attrs, [:gender, :year_of_birth, :level_of_education, :user_id])
    |> validate_required([:gender, :year_of_birth, :level_of_education, :user_id])
    |> validate_inclusion(:gender, ["male", "female", "other", "prefer not to say"])
    |> validate_inclusion(:year_of_birth, 1900..2022)
    |> validate_inclusion(:level_of_education, ["high school", "bachelor's degree", "graduate degree", "other", "prefer not to say"])
    |> unique_constraint(:user_id)
  end
end
