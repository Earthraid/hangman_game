defmodule TextClient.Interact do
  alias TextClient.{Player, State}

  @hangman_server :hangman@jerrad
  def start() do
    new_game()
    |> setup_state()
    |> play()
  end

  def play(state) do
    Player.play(state)
  end

  defp setup_state(game) do
    %State{game_service: game, tally: Hangman.tally(game)}
  end

  defp new_game() do
    Node.connect(@hangman_server)
    :rpc.call(@hangman_server, Hangman, :new_game, [])
  end
end
