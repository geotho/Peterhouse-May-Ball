class MetricsController < ApplicationController
  before_action :is_admin
  before_action :authenticate_user!

  def cashflow
    @ticket_types = TicketType.all.order(:name)
  end

  def payments
    @overdue_payments = User.users_with_overdue_payments
  end

  private
    def is_admin
      unless current_user.try(:admin?)
        flash[:error] = 'You are not an admin'
        redirect_to '/'
      end
    end
end
