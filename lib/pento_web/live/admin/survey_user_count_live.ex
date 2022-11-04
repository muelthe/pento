defmodule PentoWeb.Admin.SurveyUserCountLive do
  use PentoWeb, :live_component
  alias PentoWeb.Presence

  def update(_assigns, socket) do
    {:ok,
      socket
      |> assign_survey_user_count()}
  end

  defp assign_survey_user_count(socket) do
    assign(socket, :user_count, Presence.number_of_survey_users())
  end
end
