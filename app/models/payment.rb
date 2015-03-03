class Payment < ActiveRecord::Base
  belongs_to :user

  after_create :email_confirmation

  enum method: [
       :cheque,
       :bank_transfer,
       :discount
       ]

  private
    def email_confirmation
      UserMailer.payment_confirmation(self.user, self).deliver_later
    end
end
