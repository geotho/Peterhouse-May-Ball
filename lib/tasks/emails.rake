namespace :emails do
  desc 'Send white tie info to all ticket holders'
  task send_white_tie: :environment do
    counter = 0
    User.ticket_holders.each do |user|
      UserMailer.white_tie(user).deliver_later
      counter += 1
    end
    puts "Sent #{counter} white tie emails."
  end

end
