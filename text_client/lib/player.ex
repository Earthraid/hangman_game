defmodule TextClient.Player do
  alias TextClient.{Mover, State, Summary, Prompter}

  # :won, :lost, :good_guess, :bad_guess, :already_used, :initializing, :incorrect_character
  def play(game = %State{tally: %{game_state: :won}}) do
    exit_with_message("You won: #{Enum.join(game.tally.letters, " ")}!")
  end

  def play(game = %State{tally: %{game_state: :lost}}) do
    IO.puts("You got: #{Enum.join(game.tally.letters, " ")} ")
    exit_with_message("You lost!")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_msg(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_msg(game, "Nope!")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_msg(game, "You already tried that!")
  end

  def play(game = %State{tally: %{game_state: :incorrect_character}}) do
    continue_with_msg(game, "Please use lowercase letters only!")
  end

  def play(game) do
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.move()
    |> play()
  end

  def display(game) do
    play(game)
  end

  def prompt(game) do
    game
  end

  def make_move(game) do
    game
  end

  defp continue_with_msg(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end
end
