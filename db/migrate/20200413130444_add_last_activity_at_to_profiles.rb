class AddLastActivityAtToProfiles < ActiveRecord::Migration[6.0]
  class Profile < ApplicationRecord
  end

  def change
    add_column :profiles,
               :last_activity_at,
               :timestamp,
               precision: 6,
               null: true

    say_with_time("update last_activity_at column to updated_at") do
      Profile.where(last_activity_at: nil).
              update_all('last_activity_at = updated_at')
    end
    change_column_null(:profiles, :last_activity_at, false)
    add_index :profiles, :last_activity_at
  end
end
