defmodule Plug.AssignTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import ExUnit.CaptureLog
  require Logger

  test "Does not interfere with a basic request" do
    conn = conn(:get, "/hello")
    opts = Plug.Assign.init([])
    conn = Plug.Assign.call(conn, opts)
    assert conn.assigns == %{}
  end

  test "Assigns variables with keyword list" do
    conn = conn(:get, "/hello")
    opts = Plug.Assign.init(foo: "fooset", bar: true, baz: 42)
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
    opts = Plug.Assign.init([{:foo, "bar"}])
    conn = Plug.Assign.call(conn, opts)
    assert conn.assigns == %{existing: true, foo: "bar"}
  end

  test "Overrides existing keys" do
    conn = conn(:get, "/hello") |> assign(:foo, 1)
    opts = Plug.Assign.init(foo: 2)
    conn = Plug.Assign.call(conn, opts)
    assert conn.assigns == %{foo: 2}
  end

  defp test_invalid_assigns(assigns) do
    conn = conn(:get, "/hello")
    opts = Plug.Assign.init(assigns)
    Plug.Assign.call(conn, opts)
  end

  test "Invalid assignments" do
    assert_raise ArgumentError, fn -> Plug.Assign.init(1) end
    assert_raise ArgumentError, fn -> Plug.Assign.init(:two) end

    assert capture_log(fn -> test_invalid_assigns([3]) end) =~ "Invalid assign"
    assert capture_log(fn -> test_invalid_assigns(["four"]) end) =~ "Invalid assign"
    assert capture_log(fn -> test_invalid_assigns([:five]) end) =~ "Invalid assign"
    assert capture_log(fn -> test_invalid_assigns([:six, 6]) end) =~ "Invalid assign"
    assert capture_log(fn -> test_invalid_assigns([:seven, foo: "foo"]) end) =~ "Invalid assign"
    assert capture_log(fn -> test_invalid_assigns(~c"eight") end) =~ "Invalid assign"

    assert capture_log(fn -> test_invalid_assigns([{1, "one"}]) end) =~ "Invalid key"
    assert capture_log(fn -> test_invalid_assigns(%{"two" => 2}) end) =~ "Invalid key"
  end
end
