class CreateJwtBlacklist < ActiveRecord::Migration[6.1]
  def change
    create_table :jwt_blacklists do |t|

      t.timestamps
    end
  end
end
