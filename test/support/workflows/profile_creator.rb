# frozen_string_literal: true

module Workflows
  # Creates profiles from attributes
  class ProfileCreator
    def initialize(collection_attributes: [], fixtures: [])
      @collection_attributes = collection_attributes
      @fixtures = fixtures
    end

    def call
      model_class = Profile
      records = []
      @collection_attributes.each do |attributes|
        records << model_class.create!(attributes)
      end
      @fixtures.each do |name|
        records << model_class.create!(attributes_for(name))
      end

      records
    end

    def attributes_for(name)
      data[name]
    end

    private

    def data
      Psych.load(
        File.read(Rails.root.join('test', 'fixtures', 'profiles.yml')),
        symbolize_names: true
      )
    end
  end
end
