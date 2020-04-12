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

avatar_files = Dir[Rails.root.join('db', 'seeds', 'avatars', '*.jpg')]
header_images = Dir[Rails.root.join('db', 'seeds', 'headers', '*.jpg')]

model_class = Profile
records = []
CSV.foreach(seed_csv, headers: true) do |row|
  record = model_class.find_or_initialize_by(row.to_h)
  # randomly add avatar
  if (rand > 0.3)
    file = avatar_files.sample
    record.avatar.attach(io: File.open(file), filename: File.basename(file))
  end

  # randomly add header
  if (rand > 0.8)
    file = header_images.sample
    record.header.attach(io: File.open(file), filename: File.basename(file))
  end

  record.save!

  records << record
end
puts "Imported #{records.count} #{model_class} records"
