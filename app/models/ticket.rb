class Ticket < ActiveRecord::Base
  belongs_to :user

  enum status: [
    :applied,
    :not_allocated,
    :reserved,
    :printed,
    :admitted
  ]

  enum type: [
    :standard,
    :dining
    # todo: populate ticket types
    ]
end
