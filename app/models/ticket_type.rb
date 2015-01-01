class TicketType < ActiveRecord::Base
  after_initialize :assign_default_values
  validates :name, :price, :max_number, :number_allocated, :for_sale, :size, presence: true
  private
    def assign_default_values
      self.for_sale = false if self.for_sale.nil?
      self.number_allocated = 0 if self.number_allocated.nil?
      self.size = 2 if self.size.nil?
    end
end
