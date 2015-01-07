class TicketType < ActiveRecord::Base
  has_many :tickets

  after_initialize :assign_default_values
  validates :name, :price, :max_number, :number_allocated, :size, presence: true

  def self.for_sale
    TicketType.where(:for_sale => true)
  end  

  private
    def assign_default_values
      self.number_allocated = 0 if self.number_allocated.nil?
      self.size = 2 if self.size.nil?
      self.for_sale = false if self.for_sale.nil?
    end
end
