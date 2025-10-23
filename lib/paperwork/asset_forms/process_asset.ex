defmodule Paperwork.AssetForms.ProcessAsset do
  use Ash.Resource,
    otp_app: :paperwork,
    domain: Paperwork.AssetForms,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "process_assets"
    repo Paperwork.Repo
  end

  attributes do
    uuid_primary_key :id  # UUID enabled!

    # From your form
    attribute :date_submitted, :date, default: &Date.utc_today/0
    attribute :phone_number, :string
    attribute :department, :string
    attribute :reason_for_request, :string
    attribute :asset_changes_requested, :string

    # Process status
    attribute :process_status, :atom do
      constraints one_of: [:submitted, :approved, :discarded, :recycling, :trash, :gov_deals]
      default :submitted
    end

    attribute :current_step, :atom do
      constraints one_of: [:submitted, :approved, :discarded, :recycling, :trash, :gov_deals]
      default :initial_review
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    # Custom actions for workflow
    update :approve do
      accept [:process_status, :current_step]
    end

    update :discard do
      change set_attribute(:process_status, :discarded)
    end
  end

  relationships do
    belongs_to :requestor, Paperwork.Accounts.User
    belongs_to :asset, Paperwork.Inventory.Asset
  end
end
