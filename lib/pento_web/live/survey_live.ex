defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias Pento.{Survey, Catalog}
  alias PentoWeb.DemographicLive
  alias PentoWeb.RatingLive
  alias Phoenix.LiveView.JS

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign_demographic()
      |> assign_products()
      |> assign_toggle_class()
      |> assign_toggle_comp()
    }
  end

  def handle_event("toggle_class", %{"toggle" => "+ expand"}, socket) do
    {:noreply, assign(socket,
      toggle_value: "- contract",
      toggle_display: "show")}
  end

  def handle_event("toggle_class", %{"toggle" => "- contract"}, socket) do
    {:noreply, assign(socket,
      toggle_value: "+ expand",
      toggle_display: "hide")}
  end

  def handle_event("toggle_comp", %{"comp" => "+ expand"}, socket) do
    {:noreply, assign(socket,
      comp_toggle: true,
      comp_display_value: "- contract")}
  end

  def handle_event("toggle_comp", %{"comp" => "- contract"}, socket) do
    {:noreply, assign(socket,
      comp_toggle: false,
      comp_display_value: "+ expand")}
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_info({:created_rating, updated_product, product_index}, socket) do
    {:noreply, handle_rating_created(socket, updated_product, product_index)}
  end

  def handle_rating_created(
        %{assigns: %{products: products}} = socket,
        updated_product,
        product_index
      ) do
    socket
    |> put_flash(:info, "Rating submitted successfully")
    |> assign(
      :products,
      List.replace_at(products, product_index, updated_product)
    )
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket,
      :demographic,
      Survey.get_demographic_by_user(current_user))
  end

  defp handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic created successfully")
    |> assign(:demographic, demographic)
  end

  defp assign_products(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :products, list_products(current_user))
  end

  defp list_products(user) do
    Catalog.list_products_with_user_rating(user)
  end

  defp assign_toggle_class(socket) do
    assign(socket,
    toggle_value: "+ expand",
    toggle_display: "hide")
  end

  defp assign_toggle_comp(socket) do
    assign(socket,
    comp_toggle: nil,
    comp_display_value: "+ expand")
  end
end
