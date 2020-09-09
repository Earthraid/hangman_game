defmodule Hangman.Application do
  use DynamicSupervisor

  def start(_type, args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def start_child(args) do
    spec = %{id: Hangman.Server, start: {Hangman.Server, :start_link, args}}

    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  def init(args) do
    DynamicSupervisor.init(
      strategy: :one_for_one,
      extra_arguments: args
    )
  end
end
