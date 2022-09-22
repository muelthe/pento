defmodule PentoWeb.SurveyLive.Component do
  use Phoenix.Component

  def title(assigns) do
    ~H"""
    <h2>
      <%= @title %> - <%= render_slot(@inner_block) %>
    </h2>
    """
  end

  def list(assigns) do
    ~H"""
    <h4>Function component renders a list</h4>
    <button phx-click="add_list">Add list</button>
    <button phx-click="update_list">update list</button>
    <ul>
    <%= for item <- @list do %>
      <li><%= item %></li>
    <% end %>
    </ul>
    """
  end

  def toggle_class(assigns) do
    ~H"""
      <button phx-click="toggle_class" phx-value-toggle={@toggle_value}><%= @toggle_value %></button>
      <div class={@toggle_display}>
        <h3>Hello, World!</h3>
      </div>
    """
  end

  def toggle_comp(assigns) do
    ~H"""
      <div>
        <h3><%= @message %></h3>
      </div>
    """
  end
end
