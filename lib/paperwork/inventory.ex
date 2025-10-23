defmodule Paperwork.Inventory do
  use Ash.Domain,
    otp_app: :paperwork

  resources do
    resource Paperwork.Inventory.Asset do
      define :create_asset, action: :create
      define :read_assets, action: :read
      define :get_asset_by_number, action: :read, get_by: :asset_number
      define :get_asset_by_id, action: :read, get_by: :id
    end
  end
end
