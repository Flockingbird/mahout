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
      {
        harry: {
          name: 'Harry Potter',
          location: 'Little Whinging',
          company_name: 'Ministry of Magic',
          last_activity_at: DateTime.now - 1.days,
          url: 'http://ministry.gov.wz',
          bio: 'Had some beef with a snakey guy, now proud father and civil servant',
          contact_details: [
            {
              key: 'Home',
              value: '+420 (252) 658-3548',
              type: 'phone'
            },
            {
              key: 'Work',
              value: '773-384-0939',
              type: 'phone'
            },
            {
              key: 'Work',
              value: 'h.potter@ministry.gov.wz',
              type: 'email'
            },
            {
              key: 'Private',
              value: 'scarface@wmail.wz',
              type: 'email'
            }
          ]
        },
        ron: {
          name: 'Ron Weasly',
          location: 'The Burrow',
          bio: 'Carrottop, Auror and clumsy.'
        }
      }
    end
  end
end
