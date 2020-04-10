module Mahout
  # Instance settings
  class Application < Rails::Application
    config.catalyst = { 
      logo: 'catalyst_logo.png',
      name: 'Catalyst Inc.',
      phone: '+31 6 12345678',
      address: 'Stationsplein 26, Nijmegen, the Netherlands',
      email: 'contact@example.com',
      url: 'https://cataly.st',
      call_to_action_label: 'Schedule an Appointment',
      call_to_action_dest: 'http://example.com/contact'
    }
  end
end
