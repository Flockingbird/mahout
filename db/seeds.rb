# frozen_string_literal: true

require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Profiles
seed_csv = Rails.root.join('db', 'seeds', 'profiles.csv')
model_class = Profile
records = []
CSV.foreach(seed_csv, headers: true) do |row|
  records << model_class.find_or_create_by(row.to_h)
end
puts "Imported #{records.count} #{model_class} records"
