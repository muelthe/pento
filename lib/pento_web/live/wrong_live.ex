defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess: ",
       session_id: session["live_socket_id"],
       actual: Enum.random(1..10) |> to_string(),
       win: false
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n} phx-value-actual={@actual}><%= n %></a>
      <% end %>
    </h2>
    <h2>
      <%= if @win do %>
        <%= live_patch("reset", to: PentoWeb.Router.Helpers.live_path(@socket, PentoWeb.WrongLive)) %>
      <% end %>
    </h2>
    <pre>
      <%= @current_user.username %>
      <%= @session_id %>
    </pre>
    """
  end

  def handle_params(_params, _url, socket) do
    {:noreply,
     assign(socket,
       score: 0,
       message: "Make a guess: ",
       actual: Enum.random(1..10) |> to_string(),
       win: false
     )}
  end

  def handle_event("guess", %{"number" => guess, "actual" => actual}, socket)
      when guess == actual do
    message = "Your guess: #{guess}. Correct!"
    score = socket.assigns.score + 2

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score,
        win: true,
        actual: Enum.random(1..10) |> to_string()
      )
    }
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    score = socket.assigns.score - 1

    message =
      "Your guess: #{guess}. Wrong. Guess again (hint, it is #{higher_or_lower(guess, socket.assigns.actual)})."

    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end

  defp higher_or_lower(guess, actual) do
    cond do
      String.to_integer(actual) > String.to_integer(guess) -> "HIGHER"
      true -> "LOWER"
    end
  end
end
