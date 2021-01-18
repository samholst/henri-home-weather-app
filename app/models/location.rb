class Location < ApplicationRecord
  validates :zip, presence: true
end
