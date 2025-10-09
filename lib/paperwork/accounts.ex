defmodule Paperwork.Accounts do
  use Ash.Domain, otp_app: :paperwork, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Paperwork.Accounts.Token
    resource Paperwork.Accounts.User
  end
end
