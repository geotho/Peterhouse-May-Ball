class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_type

  enum status: [
    :applied,
    :not_allocated,
    :reserved,
    :printed,
    :admitted
  ]
end
