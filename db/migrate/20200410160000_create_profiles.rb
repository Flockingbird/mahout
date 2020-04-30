# frozen_string_literal: true

##
# Create basic profiles
class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :name
      t.string :location
      t.string :company_name
      t.string :url
      t.text :bio

      t.timestamps
    end
  end
end
