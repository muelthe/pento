defmodule Pento.Catalog do
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias Pento.Repo

  alias Pento.Catalog.{Product, Search}

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Gets a single product by SKU.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product_by_sku!(1234567)
      %Product{}

      iex> get_product_by_sku!(9876543)
      ** (Ecto.NoResultsError)

  """
  def get_product_by_sku(sku) do
    Repo.get_by(Product, sku: sku)
  end

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for validating product SKU searches

  ## Examples

      iex> change_search(sku)
      %Ecto.Changeset{data: %Search{}}
  """
  def change_search(%Search{} = search, attrs \\ %{}) do
    Search.changeset(search, attrs)
  end

  @doc """
  Markdown product price (price must be lower than current value)

  ## Examples

      iex> markdown_product(product, %{unit_price: new_value})
      {:ok, %Product{}}

      iex> markdown_productproduct, %{unit_price: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def markdown_product(%Product{} = product, attrs) do
    product
    |> Product.markdown_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns a list of products with ratings associtated to the user id

  ## Examples

      iex> list_product_with_user_rating(%{id: 1})
      [%Product{ratings: [%Rating{}]}, ...]

      iex> list_product_with_user_rating(%{id: 99})
      [%Product{ratings: []}, ...]

  """
  def list_products_with_user_rating(user) do
    Product.Query.with_user_ratings(user)
    |> Repo.all()
  end

  @doc """
  Returns a list of products filtered by age group or gender and with an average rating for each product

  ## Example

    iex> products_with_average_ratings(%{age_group_filter: age_group_filter})
    [{"product1", 2.3}, {"product2", 4.8}, ...]
  """
  def products_with_average_ratings(
    %{age_group_filter: age_group_filter},
    %{gender_filter: gender_filter}) do
    Product.Query.with_average_ratings()
    |> Product.Query.join_users()
    |> Product.Query.join_demographics()
    |> Product.Query.filter_by_age_group(age_group_filter)
    |> Product.Query.filter_by_gender(gender_filter)
    |> Repo.all()
  end

  def products_with_zero_ratings do
    Product.Query.with_zero_ratings()
    |> Repo.all()
  end

end
