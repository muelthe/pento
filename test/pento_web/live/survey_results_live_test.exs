defmodule PentoWeb.SurveyResultsLiveTest do
  use Pento.DataCase
  alias PentoWeb.SurveyResultsLive
  alias Pento.{Account, Survey, Catalog}

  @create_product_attrs %{
    description: "test description",
    name: "Test Game",
    sku: 42,
    unit_price: 120.5
  }
  @create_user_attrs %{
    email: "test@test.com",
    password: "passwordpassword"
  }
  @create_user2_attrs %{
    email: "another-person@email.com",
    password: "passwordpassword"
  }
  @create_demographic_attrs %{
    gender: "female",
    year_of_birth: DateTime.utc_now.year - 15
  }
  @create_demographic2_attrs %{
    gender: "male",
    year_of_birth: DateTime.utc_now.year - 30
  }

  defp product_fixture do
    {:ok, product} = Catalog.create_product(@create_product_attrs)
    product
  end

end
