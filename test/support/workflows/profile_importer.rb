# frozen_string_literal: true

module Workflows
  require 'csv'
  # Imports profiles from a CSV
  class ProfileImporter
    def initialize(count: 1)
      @count = count
    end

    def call
      seed_csv = Rails.root.join('db/seeds/profiles.csv')
      model_class = Profile

      records = []
      amt_created = 0
      CSV.foreach(seed_csv, headers: true) do |row|
        records << model_class.create!(row.to_h)
        amt_created += 1
        break if amt_created >= @count
      end

      records
    end
  end
end
