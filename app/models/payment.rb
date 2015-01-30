class Payment < ActiveRecord::Base
  belongs_to :user

  enum method: [
       :cheque,
       :bank_transfer
       ]
end
