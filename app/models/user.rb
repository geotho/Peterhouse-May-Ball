class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:raven]

  # validate :is_alumnus_or_petrean

  attr_accessor :first_name
  attr_accessor :surname
  attr_accessor :matric

  has_many :tickets
  has_many :payments
  has_many :charges, through: :tickets
  has_many :ticket_types, through: :tickets

  def is_alumnus_or_petrean
    is_alumnus = false
    unless self.first_name.nil?
      params = {first_name: self.first_name.downcase, surname: self.surname.downcase, matric: self.matric}
      is_alumnus = Alumnus.where(params).count == 1
    end
    unless self.petrean? || self.medwards? || is_alumnus
      errors.add(:first_name, 'You could not be verified by our alumni records. ' +
          'Please email ticketing@peterhousemayball2015.com if this is an error.')
    end
  end

  def title
    self.payment_reference
  end

  def committee?
    return %w(bm424 en291 gh376 gk350 gt319 is351 jjb71 jk566 jnr26 jw813 mf465 oew23 smv25 wa239)
        .map {|x| x + '@cam.ac.uk'}
        .include?(self.email)
  end

  def can_get_more_tickets?
    return self.tickets.size < self.max_tickets && self.available_ticket_groups.size > 0
  end

  def payment_deadline
    return self.charges.pluck(:created_at).last + 60*60*24*30
  end

  def total_owed
    charges_total = self.charges.pluck(:amount).reduce(:+)
    payments_total = self.payments.pluck(:amount).reduce(:+)
    charges_total ||= 0
    payments_total ||= 0
    return charges_total - payments_total
  end

  def permitted_ticket_groups
    if self.alumnus
      return [2]
    elsif self.petrean
      return [1,3]
    end
    return [3]
  end

  def max_tickets
    if self.committee?
      return 50
    elsif self.alumnus
      return 6
    elsif self.petrean
      return 3
    end
    return 1
  end

  def available_ticket_groups
    ticket_groups = self.permitted_ticket_groups
    ticket_groups -= self.ticket_types.pluck(:ticket_group) unless self.alumnus? || self.petrean?
    ticket_groups -= [nil]
    return TicketType.group_available(ticket_groups)
  end

  def new_ticket_status
    # if self.tickets.size <= 1
    return :reserved
    # end
    # return :waiting_list
  end

  def payment_reference
    if self.alumnus
      return self.email
    end
    return self.email[0 ... self.email.index('@')]
  end

  def self.from_omniauth(auth_hash)
    data = auth_hash.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(email: data["email"],
            password: Devise.friendly_token[0,20])
    end
    user
  end
end
