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

  def waiting_list_approved(user, ticket)
    @user = user
    @ticket = ticket
    mail(to: @user.email, subject: 'Peterhouse May Ball 2015: Ticket Application Successful')
  end

  def payment_confirmation(user, payment)
    @user = user
    @payment = payment
    treasurer = 'treasurer@peterhousemayball2015.com'
    mail(to: @user.email, reply_to: treasurer, cc: treasurer,
         subject: 'Peterhouse May Ball 2015: Payment Confirmation')
  end

  def white_tie(user)
    @user = user
    sponsorship = 'sponsorship@peterhousemayball2015.com'
    mail(to: @user.email, reply_to: sponsorship,
        subject: 'Peterhouse May Ball 2015: White Tie Hire')
  end
end
