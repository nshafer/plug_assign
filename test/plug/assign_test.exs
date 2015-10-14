defmodule Plug.AssignTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "Does not interfere with a basic request" do
    conn = conn(:get, "/hello")
    opts = Plug.Assign.init([])
    conn = Plug.Assign.call(conn, opts)
    assert conn.assigns == %{}
  end

  test "Assigns variables with keyword list" do
    conn = conn(:get, "/hello")
    opts = Plug.Assign.init([foo: "fooset", bar: true, baz: 42])
    conn = Plug.Assign.call(conn, opts)
    assert conn.assigns == %{foo: "fooset", bar: true, baz: 42}
  end

  test "Assigns variables with map" do
    conn = conn(:get, "/hello")
    opts = Plug.Assign.init(%{foo: "fooset", bar: true, baz: 42})
    conn = Plug.Assign.call(conn, opts)
    assert conn.assigns == %{foo: "fooset", bar: true, baz: 42}
  end

  test "Does not interfere with existing non-matching keys" do
    conn = conn(:get, "/hello") |> assign(:existing, true)
    opts = Plug.Assign.init([foo: "bar"])
    conn = Plug.Assign.call(conn, opts)
    assert conn.assigns == %{existing: true, foo: "bar"}
  end

  test "Overrides existing keys" do
    conn = conn(:get, "/hello") |> assign(:foo, 1)
    opts = Plug.Assign.init([foo: 2])
    conn = Plug.Assign.call(conn, opts)
    assert conn.assigns == %{foo: 2}
  end
end
