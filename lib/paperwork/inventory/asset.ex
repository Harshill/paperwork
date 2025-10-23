defmodule Paperwork.Inventory.Asset do
  use Ash.Resource,
    otp_app: :paperwork,
    domain: Paperwork.Inventory,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "assets"
    repo Paperwork.Repo
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :asset_number, :string do
      allow_nil? false
      public? true
    end

    attribute :description, :string
    attribute :location, :string
    attribute :status, :atom do
      constraints one_of: [:active, :inactive, :pending_disposal, :discarded]
      default :active
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at

  end

  actions do
    defaults [:read, :destroy, :create, :update]
    default_accept [:asset_number, :description, :location]

    update :discard do
      change set_attribute(:status, :discarded)
    end
  end

  identities do
    identity :unique_asset_number, [:asset_number]
  end

  relationships do
    has_many :paperwork_requests, Paperwork.AssetForms.ProcessAsset do
      destination_attribute :asset_id  # Tell it which field to use
    end
  end

end
