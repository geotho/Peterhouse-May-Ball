class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:raven]

  has_many :tickets
  has_many :payments
  has_many :charges, through: :tickets
  has_many :ticket_types, through: :tickets

  def title
    self.payment_reference
  end

  def can_get_more_tickets?
    return self.tickets.size < self.max_tickets && self.available_ticket_groups.size > 0
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
    if self.alumnus
      return 3
    elsif self.petrean
      return 3
    end
    return 1
  end

  def available_ticket_groups
    return TicketType.group_available(self.permitted_ticket_groups - self.ticket_types.pluck(:ticket_group) - [nil])
  end

  def new_ticket_status
    if self.petrean
      if self.tickets.size <= 1
        return :applied
      end
    end
    return :waiting_list
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
