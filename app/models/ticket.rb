class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_type
  has_many :charges

  validates :donation, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :assign_default_values

  enum status: [
    :applied,
    :not_allocated,
    :reserved,
    :printed,
    :admitted
  ]

  private
    def assign_default_values
      self.status = :applied if self.status.nil?
      self.donation = 0 if self.donation.nil?
    end
end
