defmodule PentoWeb.Presence do
  use Phoenix.Presence,
  otp_app: :pento,
  pubsub_server: Pento.PubSub

  alias PentoWeb.Presence

  @user_activity_topic "user_activity"
  @number_of_survey_users_topic "number_of_survey_users"

  def track_number_of_survey_users(pid, user_email) do
    Presence.track(
      pid,
      @number_of_survey_users_topic,
      "users",
      %{users: [%{email: user_email}]}
    )
  end

  def number_of_survey_users do
    Presence.list(@number_of_survey_users_topic)
    |> count_number_of_survey_users()
  end

  def track_user(pid, product, user_email) do
    Presence.track(
      pid,
      @user_activity_topic,
      product.name,
      %{users: [%{email: user_email}]}
    )
  end

  defp count_number_of_survey_users(%{"users" => %{metas: metas}}) do
    Enum.map(metas, &users_from_meta_map/1)
    |> Enum.uniq()
    |> Enum.count
  end

  defp count_number_of_survey_users(_empty_map), do: 0

  def list_products_and_users do
    Presence.list(@user_activity_topic)
    |> Enum.map(&extract_product_with_users/1)
  end

  defp extract_product_with_users({product_name, %{metas: metas}}) do
    {product_name, users_from_metas_list(metas)}
  end

  defp users_from_metas_list(metas_list) do
    Enum.map(metas_list, &users_from_meta_map/1)
    |> List.flatten()
    |> Enum.uniq()
  end

  def users_from_meta_map(meta_map) do
    get_in(meta_map, [:users])
  end

end
