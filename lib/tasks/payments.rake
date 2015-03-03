namespace :payments do
  desc 'Send a payment confirmation to everyone'
  task send_payment_confirmations: :environment do
    counter = 0
    Payment.find_each do |payment|
      payment.email_confirmation
      counter += 1
    end
    puts "Sent #{counter} emails."
  end

end
