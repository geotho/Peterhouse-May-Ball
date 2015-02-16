namespace :tickets do
  desc "Take all the tickets that are waiting_list, build charges for them, set reserved and send email notification"
  task approve_all_waiting: :environment do
    Ticket.where(status: Ticket.statuses[:waiting_list]).find_each do |ticket|
      ticket.move_from_waiting_list_to_reserved!
    end
  end

end
