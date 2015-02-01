class TicketType < ActiveRecord::Base
  has_many :tickets

  after_initialize :assign_default_values
  validates :name, :price, :max_number, :number_allocated, :size, presence: true

  def self.for_sale
    TicketType.where(:for_sale => true)
  end

  def sold_out
    self.tickets.where(status: Ticket.statuses[:reserved]).count >= self.max_number
  end

  def short_name
    name = self.name
    c = "champagne"
    d = "dining"
    s = "standard"
    case
      when name.include?(c)
        c
      when name.include?(d)
        d
      else
        s
    end
  end

  def self.group_available(groups)
    TicketType.where(:ticket_group => groups, :for_sale => true)
  end

  private
    def assign_default_values
      self.number_allocated = 0 if self.number_allocated.nil?
      self.size = 2 if self.size.nil?
      self.for_sale = false if self.for_sale.nil?
    end
end
