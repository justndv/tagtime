defmodule Tagtime do
  @moduledoc """
  Implementation of the TagTime universal ping schedule.

  https://forum.beeminder.com/t/official-reference-implementation-of-the-tagtime-universal-ping-schedule/4282
  """

  alias Tagtime.RNG

  # First ping of TagTime
  @urping 1_184_097_393

  # Initial state for the RNG
  @seed 11_193_462

  @doc """
  Returns the seed (RNG state) and most recent ping <= t.
  """
  @spec init(number) :: {integer, integer}
  def init(t) do
    # Starting with the urping, fast forward to the most recent ping <= t
    init(t, @seed, @urping, @seed, @urping)
  end

  # Walk forward until the first ping is hit
  defp init(t, seed, last_ping, _s, _p) when last_ping <= t do
    s = seed
    p = last_ping
    {seed, last_ping} = next_ping(seed, last_ping)
    init(t, seed, last_ping, s, p)
  end

  # Rewinds a step to return the most recent ping <= t
  defp init(t, _seed, last_ping, s, p) when last_ping > t do
    {s, p}
  end

  @doc """
  Returns new seed and the unix time of the next ping.

  `gap` is the average time between pings in seconds, 45 minutes by default.
  """
  @spec next_ping(integer, integer, integer) :: {integer, integer}
  def next_ping(seed, last_ping, gap \\ 45 * 60) do
    {new_seed, generated_number} = RNG.exprand(seed, gap)
    # Gap must be at least 1 second out
    calculated_gap = max(1, round(generated_number))

    {new_seed, last_ping + calculated_gap}
  end
end
