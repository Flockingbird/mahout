# frozen_string_literal: true

##
# Add a slug field to profiles
class AddSlugToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :slug, :string
    add_index :profiles, :slug, unique: true
  end
end
