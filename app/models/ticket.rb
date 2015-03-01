class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_type
  has_many :charges, dependent: :destroy

  validates :user, :ticket_type, :donation, :name, :second_name, presence: true
  validates :donation, numericality: { greater_than_or_equal_to: 0 }
  # validate :ticket_type_must_be_available
  validate :ticket_type_must_not_be_sold_out, on: :create
  validate :first_guest_birthday_eighteen
  validate :second_guest_birthday_eighteen

  def first_guest_birthday_eighteen
    if self.first_guest_date_of_birth > Date.new(2015,6,17) - 18.years
      errors.add(:first_guest_date_of_birth, 'Guests must be at least 18 years old on the day of the ball.')
    end
  end

  def second_guest_birthday_eighteen
    if self.second_guest_date_of_birth > Date.new(2015,6,17) - 18.years
      errors.add(:second_guest_date_of_birth, 'Guests must be at least 18 years old on the day of the ball.')
    end
  end

  def ticket_type_must_not_be_sold_out
    if self.ticket_type.sold_out
      errors.add(:ticket_type, 'That particular ticket type is now sold out. Please choose another.')
    end
  end

  # def ticket_type_must_be_available
  #   unless self.user.available_ticket_groups.pluck(:id).include? ticket_type_id
  #     errors.add(:ticket_type, "The ticket type you have chosen is not available.")
  #   end
  # end

  def payment_deadline
    return self.charges.pluck(:created_at).last + 60*60*24*30
  end

  def move_from_waiting_list_to_reserved!
    if self.waiting_list?
      self.build_charges!
      self.status = :reserved
      if self.save!({validate: false})
        UserMailer.waiting_list_approved(self.user, self).deliver_later
      else
        return self.errors
      end
    end
  end

  def build_charges!
    self.charges.build([{amount: self.ticket_type.price, description: self.ticket_type.name},
                        {amount: self.donation, description: 'Ticket donation'}])
  end

  after_initialize :assign_default_values

  enum status: [
    :reserved,
    :waiting_list,
    :not_allocated,
    :confirmed,
    :printed,
    :admitted
  ]

  private
    def assign_default_values
      self.status = :reserved if self.status.nil?
      self.donation = 0 if self.donation.nil?
    end
end
