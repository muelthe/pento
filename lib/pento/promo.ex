defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  # stub - send email (no email service error handling etc.)
  def send_promo(recipient, attrs) do
    changeset = change_recipient(recipient, attrs)

    case changeset_valid?(changeset) do
      :true -> {:ok, :email_sent} # email sent
      :false -> {:error, changeset.errors}
    end
  end

  defp changeset_valid?(%Ecto.Changeset{valid?: false}), do: :false

  defp changeset_valid?(%Ecto.Changeset{valid?: true}), do: :true
end
