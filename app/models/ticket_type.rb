class TicketType < ActiveRecord::Base
  validates :name, :price, :max_number, :number_allocated, :for_sale, :size, presence: true
end
