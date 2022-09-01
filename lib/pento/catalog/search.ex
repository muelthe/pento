defmodule Pento.Catalog.Search do
  import Ecto.Changeset

  defstruct [:search]
  @types %{search: :string}

  @doc false
  def changeset(%__MODULE__{} = search, params \\ %{}) do
    {search, @types}
    |> cast(params, Map.keys(@types))
    |> validate_required([:search])
    |> validate_format(:search, ~r/[0-9]{7,}/)
  end
end
