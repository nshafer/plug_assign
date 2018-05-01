# Plug.Assign

A simple plug to allow setting variables in a connection.  For example, as a way to set default variables for a controller, view or template to use in a Phoenix app.

## Installation

The package can be installed from Hex:

Add plug_assign to your list of dependencies in `mix.exs`:

```elixir
    def deps do
      [{:plug_assign, "~> 1.0.0"}]
    end
```

Fetch and install the dependencies

```sh
    $ mix deps.get
```

Define assigns as part of your plug stack

```elixir
    plug Plug.Assign, foo: "bar", bar: true, baz: 42
```

Or Set variables for templates to use in a Phoenix Pipeline

```elixir
    pipeline :admin do
      plug Plug.Assign, admin: true
    end
```

Or directly in a Phoenix Controller

```elixir
    defmodule Blog.Admin.PostController do
      use Blog.Web, :Controller

      plug Plug.Assign, subsection: :posts
      plug Plug.Assign, %{read_request: true} when action in [:index, :show]
      ...
    end
```

### Generate documentation

```bash
    mix docs
```
