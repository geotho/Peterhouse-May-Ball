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
    if @ticket.applied?
      @ticket.charges.build([{amount: @ticket.ticket_type.price, description: @ticket.ticket_type.name},
                             {amount: @ticket.donation, description: 'Ticket donation'}])
    end

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to authenticated_root_url, notice: 'Ticket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to authenticated_root_url, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
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
      params.require(:ticket).permit(:name, :second_name, :donation, :ticket_type_id)
    end
end
