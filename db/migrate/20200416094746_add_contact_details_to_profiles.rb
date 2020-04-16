class AddContactDetailsToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :contact_details, :jsonb
  end
end
