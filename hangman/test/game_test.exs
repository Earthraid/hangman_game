defmodule Hangeman.GameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state() == :initializing
    assert length(game.letters) > 0
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game =
        Game.new_game()
        |> Map.put(:game_state, state)

      assert {game, _tally} = Game.make_move(game, "x")
    end
  end

  test "occurance of letter is or is not not :already_used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "good guess" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "game won" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "i")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :already_used
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "l")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess" do
    game = Game.new_game("wibble")
    {game, _tally} = Game.make_move(game, "j")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "game lost" do
    game = Game.new_game("w")
    {game, _tally} = Game.make_move(game, "j")
    assert game.game_state == :bad_guess
    {game, _tally} = Game.make_move(game, "i")
    assert game.game_state == :bad_guess
    {game, _tally} = Game.make_move(game, "b")
    assert game.game_state == :bad_guess
    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state == :bad_guess
    {game, _tally} = Game.make_move(game, "l")
    assert game.game_state == :bad_guess
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :bad_guess
    {game, _tally} = Game.make_move(game, "k")
    assert game.game_state == :lost
  end

  test "only letters" do
    game = Game.new_game("w")
    {game, _tally} = Game.make_move(game, "1")
    assert game.game_state == :incorrect_character
  end
end
