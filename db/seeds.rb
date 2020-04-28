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

contact_lines = CSV.read(Rails.root.join('db', 'seeds', 'contact_details.csv'), headers: true).to_enum

CSV.foreach(seed_csv, headers: true) do |row|
  contact_details = []
  contact_lines.next.each do |key, value|
    next unless key && value
    type = case key
           when "Home", "Work"
             :phone
           when "Personal", "Workemail"
             :email
           when "Twitter"
             :twitter
           when "Facebook"
             :facebook
           when "Linkedin"
             :linkedin
           when "Street Address"
             :address
           end
    contact_details <<  { key: key, value: value, type: type }
  end

  attrs = row.to_h.merge(contact_details: contact_details)
  record = model_class.find_or_initialize_by(attrs)
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
