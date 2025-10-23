defmodule Paperwork.AssetForms do
  use Ash.Domain,
    otp_app: :paperwork

  resources do
    resource Paperwork.AssetForms.ProcessAsset
  end
end
