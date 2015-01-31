class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_type
  has_many :charges, dependent: :destroy

  validates :user, :ticket_type, :donation, :name, :second_name, presence: true
  validates :donation, numericality: { greater_than_or_equal_to: 0 }
  validate :ticket_type_must_be_available

  def ticket_type_must_be_available
    unless self.user.available_ticket_groups.pluck(:id).include? ticket_type_id
      errors.add(:ticket_type, "The ticket type you have chosen is not available.")
    end
  end

  def payment_deadline
    return self.charges.pluck(:created_at).last + 60*60*24*30
  end

  after_initialize :assign_default_values

  enum status: [
    :applied,
    :waiting_list,
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
