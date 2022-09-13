defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view

  alias Pento.Catalog

  def mount(_, _, socket) do
    socket =
      assign(socket,
        changeset: Catalog.change_search(%Catalog.Search{}),
        search_ready: [:false],
        search_result: nil
      )
    {:ok, socket}
  end

  def handle_event("validate", %{"search" => search}, socket) do
    changeset =
      %Catalog.Search{}
      |> Catalog.change_search(search)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("search", %{"search" => %{"search" => search}}, socket) do
    case Catalog.get_product_by_sku(search) do
      nil ->
        {:noreply, assign(socket, search_result: nil, search_ready: :true)}
      result -> {:noreply, assign(socket, search_result: result, search_ready: :true)}
    end
  end
end
