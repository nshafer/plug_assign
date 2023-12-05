# Plug.Assign

A simple plug to allow setting variables in a connection.  For example, as a way to set default variables for a controller, view or template to use in a Phoenix app.

## Installation

The package can be installed from Hex:

Add plug_assign to your list of dependencies in `mix.exs`:

```elixir
    def deps do
      [{:plug_assign, "~> 2.0.1"}]
    end
```

Fetch and install the dependencies

```sh
    $ mix deps.get
```

## Basic Usage

Define assigns as part of any plug stack.

```elixir
    plug Plug.Assign, foo: "bar", bar: true, baz: 42
```

This will set the given key/value pairs in the `assigns` map of the Plug.Conn, for you to use
in controllers, views, and templates.

One way to use this is to set variables so you can quickly determine where you are in your app.

```elixir
    pipeline :browser do
      ...
      plug Plug.Assign, admin: false
    end

    pipeline :admin do
      plug Plug.Assign, admin: true
    end
```

And then use that in a template, such as your layout.

```html
  <%= if @admin do %>
    <p>Hello, Administrator</p>
  <% end %>
```

Since you can use this anywhere you can use a plug, you can also use it in a Phoenix Controller.

```elixir
    defmodule HelloWeb.Admin.PostController do
      use HelloWeb, :controller

      plug Plug.Assign, section: :posts
      ...
    end
```

```html
  <h1><%= @section %></h1>
```

If you want to only assign a variable for certain actions, you can use the `plug ... when` format,
but be careful that bare keyword lists are only accepted as the last arguments of a macro call,
which is no longer the case with a `when` clause, so add the square brackets `[]` around your
assigns, or use a map instead.

```elixir
    defmodule HelloWeb.Admin.PostController do
      use HelloWeb, :controller

      plug Plug.Assign, [read_request: true] when action in [:index, :show]
      plug Plug.Assign, %{write_request: true} when action in [:edit, :new, :create, :update, :delete]
      ...
    end
```

## Accessing in templates

If you're using an assign in a template that may not have been set, you can't use the
`@variable` format without throwing an error, so use one of the following techniques instead:

- Access shortcut: `assigns[:admin]` - Returns `nil` if not set.
- Map.get/2: `Map.get(assigns, :admin)` - Returns `nil` if not set.
- Map.get/3: `Map.get(assigns, :admin, false) - `Returns `false` if not set.

```html
  <%= if assigns[:admin] do %>
    <p>Hello, Administrator</p>
  <% end %>
```

## Assignment formats

Assigns can be either a keyword list

```elixir
    plug Plug.Assign, foo: "bar", bar: true, baz: 42
```

Or a map, as long as the keys are atoms.

```elixir
    plug Plug.Assign, %{foo: "foo", bar: true, baz: 42}
    plug Plug.Assign, %{:foo => "foo", :bar => true, :baz => 42}
```

Any attempt to pass it anything else will throw an exception.

```bash
** (ArgumentError) Invalid assignment, must be a keyword list or map with all keys as atoms
```

## Generate documentation

```bash
    mix docs
```
