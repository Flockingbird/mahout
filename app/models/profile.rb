class Profile < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :header
end
