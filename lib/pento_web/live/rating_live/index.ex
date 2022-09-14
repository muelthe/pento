defmodule PentoWeb.RatingLive.Index do
  use Phoenix.Component
  use Phoenix.HTML
  alias PentoWeb.RatingLive.Show

  def products(assigns) do
    ~H"""
      <div class="survey-component-container">
        <.heading products={@products} />
        <.list products={@products} current_user={@current_user}/>
      </div>
    """
  end

  def heading(assigns) do
    ~H"""
      <h2>
        Ratings
        <%= if ratings_complete?(@products), do: raw "&#x2713;" %>
      </h2>
    """
  end

  def list(assigns) do
    ~H"""
      <%= for {product, index} <- Enum.with_index(@products) do %>
        <%= if rating = List.first(product.ratings) do %>
          <Show.stars rating={rating} product={product} />
        <% else %>
          <h3>Rating form coming soon!</h3>
        <% end %>
      <% end %>
    """
  end

  defp ratings_complete?(products) do
    Enum.all?(products, fn product ->
      length(product.ratings) == 1
    end)
  end
end
