defmodule Conduit.App do
  use Commanded.Application, otp_app: :conduit

  router(Conduit.Router)

  def init(config) do
    {:ok, config}
  end
end
