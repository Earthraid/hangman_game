defmodule TextClient.Summary do
  def display(game = %{tally: tally}) do
    IO.puts("Word so far: #{Enum.join(tally.letters, " ")} ")
    IO.puts("Guesses left: #{tally.turns_left} ")
    IO.puts("Already guessed: #{Enum.join(game.used, ", ")} ")

    game
  end
end
