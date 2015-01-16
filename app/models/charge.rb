class Charge < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
