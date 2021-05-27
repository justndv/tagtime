defmodule Tagtime.RNG do
  @moduledoc """
  Implementation of the pseudorandom number generator.
  """
  @ia 16_807
  @im 2_147_483_647

  defp lcg(seed) do
    Integer.mod(@ia * seed, @im)
  end

  # Returns {new_seed, random_number}
  @spec exprand(integer, integer) :: {integer, float}
  def exprand(seed, g_a_p) do
    # Mutates the seed
    new_seed = lcg(seed)
    {new_seed, -1 * g_a_p * :math.log(new_seed / @im)}
  end
end
