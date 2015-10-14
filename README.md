# Plug.Assign

A simple plug to allow setting variables in a connection.

## Installation

The package can be installed from Hex:

  1. Add plug_assign to your list of dependencies in `mix.exs`:

        def deps do
          [{:plug_assign, "~> 1.0.0"}]
        end

  2. Fetch and install the dependencies

        $ mix deps.get

  2. Define assigns as part of your plug stack

        plug Plug.Assign, foo: "bar", bar: true, baz: 42

      Or Set variables for templates to use in a Phoenix Pipeline

        pipeline :admin do
          plug Plug.Assign, admin: true
        end

      Or directly in a Phoenix Controller

        defmodule Blog.Admin.PostController do
          use Blog.Web, :Controller

          plug Plug.Assign, subsection: :posts
          plug Plug.Assign, %{read_request: true} when action in [:index, :show]
          ...
        end
