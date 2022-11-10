defmodule PentoWeb.Admin.DashboardLive do
  use PentoWeb, :live_view

  alias PentoWeb.Endpoint

  @survey_results_topic "survey_results"
  @number_of_survey_users_topic "number_of_survey_users"
  @user_activity_topic "user_activity"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Endpoint.subscribe(@survey_results_topic)
      Endpoint.subscribe(@number_of_survey_users_topic)
      Endpoint.subscribe(@user_activity_topic)
    end

    {:ok,
      socket
      |> assign(:survey_results_component_id, "survey-results")
      |> assign(:number_of_survey_users_component_id, "survey_users")
      |> assign(:user_activity_component_id, "user-activity")}
  end

  def handle_info(%{event: "rating_created"}, socket) do
    send_update(
      PentoWeb.SurveyResultsLive,
      id: socket.assigns.survey_results_component_id
    )

    {:noreply, socket}
  end

  def handle_info(%{event: "presence_diff"}, socket) do
    send_update(
      PentoWeb.Admin.UserActivityLive,
      id: socket.assigns.user_activity_component_id
    )
    send_update(
      PentoWeb.Admin.SurveyUserCountLive,
      id: socket.assigns.number_of_survey_users_component_id
    )
    {:noreply, socket}
  end
end
