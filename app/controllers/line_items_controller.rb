class LineItemsController < ApplicationController
  before_action :set_claim
  before_action :set_billing
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = @billing.line_items.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = @billing.line_items.build
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @line_item = @billing.line_items.build(line_item_params)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to [@claim, @billing], notice: 'Line item was successfully created.' }
        format.js { render :create, notice: 'Line item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to [@claim, @billing], notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to claim_billing_line_items_url }
      format.js { render :destroy }
      format.json { head :no_content }
    end
  end

  def sort
    params[:line_item].each_with_index do |id, index|
      LineItem.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def set_claim
      @claim = Claim.find(params[:claim_id])
    end

    def set_billing
      @billing = @claim.billings.find(params[:billing_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:billing_id, :quantity, :date, :cpt_code, :description, :unit_price, :total)
    end
end
