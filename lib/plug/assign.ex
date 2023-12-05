defmodule Plug.Assign do
  @moduledoc """
  Provides a Plug for adding assignments to the current connection.

  ## Example

      plug Plug.Assign, foo: "foo", bar: true, baz: 42

  ## Example of use in a Phoenix Pipeline

      pipeline :admin do
        plug Plug.Assign, admin: true
      end

  ## Example of use in a Phoenix Controller

      defmodule Blog.Admin.PostController do
        use Blog.Web, :Controller

        plug Plug.Assign, subsection: :posts
        plug Plug.Assign, %{read_request: true} when action in [:index, :show]
        ...
      end
  """

  @behaviour Plug
  @invalid_type "Invalid assignment, must be a keyword list or map with all keys as atoms."

  import Plug.Conn
  require Logger

  def init(assigns) when is_list(assigns) or is_map(assigns), do: assigns
  def init(_), do: raise(ArgumentError, message: @invalid_type)

  def call(conn, assigns) do
    Enum.reduce(assigns, conn, fn
      {k, v}, conn when is_atom(k) ->
        assign(conn, k, v)

      {k, _}, conn ->
        Logger.warning("[Plug.Assign] Invalid key: #{inspect(k)}. Keys must be an atom.")
        conn

      var, conn ->
        Logger.warning(
          "[Plug.Assign] Invalid assign: #{inspect(var)}. Assigns must be {:key, value}. " <>
            "Use a keyword list or a map with all keys as atoms."
        )

        conn
    end)
  end
end
