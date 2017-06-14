class MigrateNilUsersAllowNegativeBalanceToFalse < ActiveRecord::Migration[5.1]
  def up
    # rubocop:disable Rails/SkipsModelValidations
    User.where(allow_negative_balance: nil).
      update_all(allow_negative_balance: false)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def down
    # no-op
  end
end
