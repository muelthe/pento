defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_recipient()
     |> assign_changeset()}
  end
  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:changeset, changeset)}
  end

  def handle_event(
        "save",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do

    case Promo.send_promo(recipient, recipient_params) do
      {:ok, :email_sent} ->
        {:noreply,
          socket
          |> clear_flash()
          |> put_flash(:info, "Email sent!")}
      {:error, _error} ->
        # Log changeset error
        # Extract reason and include in message to user
        {:noreply,
          socket
          |> clear_flash()
          |> put_flash(:error, "There are errors with the form.")}
    end

  end

  def assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket
    |> assign(:changeset, Promo.change_recipient(recipient))
  end
end
