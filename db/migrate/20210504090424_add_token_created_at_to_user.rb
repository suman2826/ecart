class AddTokenCreatedAtToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :token_created_at, :datetime
  end
end
