defmodule TagtimeTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest Tagtime

  test "init returns the last ping before current" do
    current = System.system_time(:second)

    {seed, ping_before_t} = Tagtime.init(current)
    {_seed, ping_after_t} = Tagtime.next_ping(seed, ping_before_t)

    assert ping_before_t <= current
    assert ping_after_t > current
  end

  test "matches tagtime.glitch.me ping times" do
    t = 1_533_748_817

    {seed, p1} = Tagtime.init(t)
    {seed, p2} = Tagtime.next_ping(seed, p1)
    {seed, p3} = Tagtime.next_ping(seed, p2)
    {_seed, p4} = Tagtime.next_ping(seed, p3)

    assert t == p1
    assert p1 == 1_533_748_817
    assert p2 == 1_533_754_341
    assert p3 == 1_533_758_980
    assert p4 == 1_533_759_940
  end

  property "init returns the last ping before t" do
    check all t <- StreamData.integer(1_184_097_393..4_102_441_201) do
      {seed, ping_before_t} = Tagtime.init(t)
      {_seed, ping_after_t} = Tagtime.next_ping(seed, ping_before_t)

      assert ping_before_t <= t
      assert ping_after_t > t
    end
  end
end
