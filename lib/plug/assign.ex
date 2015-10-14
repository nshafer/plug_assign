defmodule Plug.Assign do
  @moduledoc """
  Provides a Plug for adding assignments to the current connection.

  ## Example

      plug Plug.Assign, foo: "bar", bar: true, baz: 42

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

  import Plug.Conn

	def init(assigns), do: assigns

	def call(conn, assigns) do
		Enum.reduce assigns, conn, fn {k, v}, conn ->
			assign(conn, k, v)
		end
	end
end
