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

  desc 'Send headliner release to all ticket holders'
  task send_headliner: :environment do
    counter = 0
    User.ticket_holders.each do |user|
      UserMailer.headliner_release(user).deliver_later
      counter += 1
    end
    puts "Sent #{counter} headliner release emails."
  end

  desc 'Send white tie info to all ticket holders'
  task send_white_tie_info: :environment do
    counter = 0
    User.ticket_holders.each do |user|
      UserMailer.white_tie_info(user).deliver_later
      counter += 1
    end
    puts "Sent #{counter} white tie info emails."
  end

  desc 'Send ticket collection info to all ticket holders'
  task send_ticket_collection_info: :environment do
    counter = 0
    User.ticket_holders.each do |user|
      UserMailer.ticket_collection(user).deliver_later
      counter += 1
    end
    puts "Sent #{counter} ticket collection info emails."
  end
end
