# Tagtime

Implementation of the [TagTime universal ping schedule](https://forum.beeminder.com/t/official-reference-implementation-of-the-tagtime-universal-ping-schedule/4282) in Elixir.

## Usage

```elixir
t = System.system_time(:second)
# Initialize RNG state and last ping, which we will need for the next ping
{state, ping_before_t} = Tagtime.init(t)
# next_ping/2 with these params now returns the first ping >= t in unix time
{state, ping} = Tagtime.next_ping(state, ping_before_t)
```

## Installation

Add `tagtime` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tagtime, "~> 0.1.0"}
  ]
end
```

The docs can be found at [https://hexdocs.pm/tagtime](https://hexdocs.pm/tagtime).
