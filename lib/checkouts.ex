defmodule Conekta.Checkouts do
  alias Conekta.Client
  alias Conekta.Handler
  alias Conekta.PaymentLinkResponse

  def create_payment_link(payment_link) do
    case Client.post_request("checkouts/", payment_link) do
      {:ok, content} ->
        body = Handler.handle_status_code(content)
        {:ok, Poison.decode!(body, as: PaymentLinkResponse)}
    end
  end

  @doc """
  Get Payment Link
  [Conekta Documenation](https://developers.conekta.com/reference/getcheckout)

  **Method**: `GET`

  Conekta.Checkouts.get_payment_link(payment_link_id)
      # => { :ok, %Conekta.PaymentLinkResponse{}}
  """
  @spec get_payment_link(String.t()) :: {:ok, any()}
  def get_payment_link(payment_link_id) do
    case Client.get_request("checkouts/#{payment_link_id}") do
      {:ok, content} ->
        content
        |> Handler.handle_status_code()
        |> then(&{:ok, Poison.decode!(&1, as: PaymentLinkResponse)})
    end
  end

  @doc """
  Cancel Payment Link
  [Conekta Documenation](https://developers.conekta.com/reference/cancelcheckout)

  **Method**: `PUT`

  Conekta.Checkouts.cancel_payment_link(payment_link_id)
      # => { :ok, %Conekta.PaymentLinkResponse{}}
  """
  @spec cancel_payment_link(String.t(), Conekta.PaymentLink.t()) :: {:ok, any()}
  def cancel_payment_link(payment_link_id, payment_link) do
    case Client.put_request("checkouts/#{payment_link_id}/cancel", payment_link) do
      {:ok, content} ->
        content
        |> Handler.handle_status_code()
        |> then(&{:ok, Poison.decode!(&1, as: PaymentLinkResponse)})
    end
  end
end
