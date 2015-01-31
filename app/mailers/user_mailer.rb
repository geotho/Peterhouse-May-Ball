class UserMailer < ActionMailer::Base
  default from: 'ticketing@peterhousemayball2015.com'

  def reserved_ticket(user, ticket)
    @user = user
    @ticket = ticket
    mail(to: @user.email, subject: 'Peterhouse May Ball 2015: Ticket Confirmation')
  end

  def waiting_list_ticket(user, ticket)
    @user = user
    @ticket = ticket
    mail(to: @user.email, subject: 'Peterhouse May Ball 2015: Waiting List')
  end

end
