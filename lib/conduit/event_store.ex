defmodule Conduit.EventStore do
  use EventStore, otp_app: :conduit

  def init(config) do
    {:ok, config}
  end
end
