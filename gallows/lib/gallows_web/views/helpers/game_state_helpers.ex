defmodule Gallows.Views.Helpers.GameStateHelpers do
  import Phoenix.HTML, only: [raw: 1, sigil_e: 2]

  @responses %{
    :initializing => {:info, "New Game!"},
    :won => {:success, "You Won!"},
    :lost => {:danger, "You Lost!"},
    :good_guess => {:success, "Good Guess!"},
    :bad_guess => {:warning, "Bad Guess!"},
    :already_used => {:info, "You already tried that letter!"},
    true: {:info, "That won't work!"}
  }

  def game_state(state) do
    @responses[state]
    |> alert()
  end

  defp alert(nil), do: " "

  defp alert({class, message}) do
    ~e"""
      <div class="alert alert-<%= class %>">
       <%= message %>
      </div>
    """
    |> raw()
  end
end
