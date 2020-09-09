defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    {:ok, socket}
  end

  def handle_in("hangman:game", _, socket) do
    push(socket, "tally", %{})
    {:reply, socket}
  end
end
