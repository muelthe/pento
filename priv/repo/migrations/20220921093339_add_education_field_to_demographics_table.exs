defmodule Pento.Repo.Migrations.AddEducationFieldToDemographicsTable do
  use Ecto.Migration

  def change do
    alter table("demographics") do
      add :level_of_education, :string
    end
  end
end
