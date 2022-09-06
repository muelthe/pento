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
    <ul>
    <%= for item <- @list do %>
      <li><%= item %></li>
    <% end %>
    </ul>
    """
  end
end
