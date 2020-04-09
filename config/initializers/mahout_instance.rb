module Mahout
  # Instance settings
  class Application < Rails::Application
    config.catalyst = { 
      logo: 'catalyst_logo.png',
      name: 'Catalyst Inc.',
      phone: '+31 6 12345678',
      address: 'Stationsplein 26, Nijmegen, the Netherlands',
      email: 'contact@example.com',
      url: 'https://cataly.st'
    }
  end
end
