# frozen_string_literal: true

##
# Add a json field to hold contact details
class AddContactDetailsToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :contact_details, :jsonb
  end
end
