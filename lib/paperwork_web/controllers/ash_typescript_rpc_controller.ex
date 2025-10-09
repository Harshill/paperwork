defmodule PaperworkWeb.AshTypescriptRpcController do
  use PaperworkWeb, :controller

  def run(conn, params) do
    result = AshTypescript.Rpc.run_action(:paperwork, conn, params)
    json(conn, result)
  end

  def validate(conn, params) do
    result = AshTypescript.Rpc.validate_action(:paperwork, conn, params)
    json(conn, result)
  end
end
