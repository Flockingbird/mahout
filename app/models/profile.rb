class Profile < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :header

  # add last_activity_at as create timestamp
  def self.timestamp_attributes_for_create
    super + ['last_activity_at']
  end
end
