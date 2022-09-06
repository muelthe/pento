defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias Pento.Survey
  alias PentoWeb.DemographicsLive
  alias __MODULE__.Component

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign_demographic()
      |> assign_title()
      |> assign_motd()
      |> assign(:list, [])
    }
  end

  def handle_event("add_list", _params, socket) do
    {:noreply,
      socket
      |> assign(:list, ["Doh", "Ray", "Me", "etc..."])}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket,
      :demographic,
      Survey.get_demographic_by_user(current_user))
  end

  defp assign_title(socket) do
    assign(socket,
      :title,
      "Welcome member to the Survey")
  end

  defp assign_motd(socket) do
    assign(socket,
      :motd,
      Enum.random(["Resistance is futile.", "Hello, World!", "Foo", "Bar", "Baz"]))
  end
end
