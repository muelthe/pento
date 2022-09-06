defmodule PentoWeb.SurveyLive.ListComponent do
  use PentoWeb, :live_component

  def update(assigns, socket) do
    {:ok,
      socket
      |> assign(assigns)
    }
  end

  def render(assigns) do
    ~H"""
    <section>
      <h4>Live component calls a function component</h4>
      <PentoWeb.SurveyLive.Component.list list={@list} />
    </section>
    """
  end
end
