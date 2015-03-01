class TicketsController < ApplicationController
  before_action :set_ticket, only: [:edit, :update]
  before_action :authenticate_user!

  # GET /tickets/new
  def new
    @ticket = current_user.tickets.build
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create

    @ticket = current_user.tickets.build(ticket_params)
    @ticket.status = current_user.new_ticket_status

    return render action: 'new' unless @ticket.valid?

    notice = %{You've been placed on the waiting list for your ticket.
        We will contact you via email with the result of your ticket application.}
    if @ticket.reserved?
      @ticket.charges.build([{amount: @ticket.ticket_type.price, description: @ticket.ticket_type.name},
                             {amount: @ticket.donation, description: 'Ticket donation'}])
      notice = 'Ticket successfully ordered. Please consult the Charges section.'
    end

    if @ticket.save
      if @ticket.reserved?
        UserMailer.reserved_ticket(current_user, @ticket).deliver_later
      elsif @ticket.waiting_list?
        UserMailer.waiting_list_ticket(current_user, @ticket).deliver_later
      end
      redirect_to authenticated_root_url, notice: notice
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    if @ticket.update(namechange_params)
      redirect_to authenticated_root_url, notice: 'Ticket was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = current_user.tickets.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      # params[:ticket]
      params.require(:ticket).permit(:name, :second_name, :donation, :ticket_type_id, :first_guest_date_of_birth, :second_guest_date_of_birth)
    end

    def namechange_params
      params.require(:ticket).permit(:name, :second_name, :first_guest_date_of_birth, :second_guest_date_of_birth)
    end
end
