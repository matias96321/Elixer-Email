defmodule MailserverTest do
  use ExUnit.Case
  doctest Mailserver

  test "greets the world" do
    assert Mailserver.hello() == :world
  end
end
