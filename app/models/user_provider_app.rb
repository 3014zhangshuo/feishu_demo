class UserProviderApp < ApplicationRecord
  has_many :user_providers

  enum channel: { qywx: 0, feishu: 1 }

  serialize :extra, Hash

  def change_extra(key:, value:)
    extra.update(key => value)
    update_extra
  end

  %i[tenant_key app_ticket].each do |mth_name|
    define_method(mth_name) { extra[mth_name] }
  end

  private

  def update_extra
    update(extra: extra_hash.to_json)
  end
end
