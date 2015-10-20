class CatRentalRequestRentalRequestController < AppliCatRentalRequestionController
  # def index
  #   @CatRentalRequests = CatRentalRequest.all
  #   render :index
  # end
  #
  # def show
  #   @CatRentalRequest = CatRentalRequest.find(params[:id])
  #   render :show
  # end
  #
  # def edit
  #   @CatRentalRequest = CatRentalRequest.find(params[:id])
  #   render :edit
  # end

  def new
    @CatRentalRequest = CatRentalRequest.new
    render :new
  end

  # def create
  #   @CatRentalRequest = CatRentalRequest.new(CatRentalRequests_params)
  #
  #   if @CatRentalRequest.save
  #     redirect_to CatRentalRequest_url(@CatRentalRequest)
  #   else
  #     render json: @CatRentalRequest.errors.full_messages, status: :unprocessable_entity
  #   end
  # end
  #
  # def update
  #   @CatRentalRequest = CatRentalRequest.find(params[:id])
  #
  #   if @CatRentalRequest.update(CatRentalRequests_params)
  #     redirect_to CatRentalRequest_url(@CatRentalRequest)
  #   else
  #     render(json: @CatRentalRequest.errors.full_messages, status: :unprocessable_entity)
  #   end
  # end

  private

  def CatRentalRequests_params
    params.require(:CatRentalRequest).permit(:cat_id, :start_date, :end_date, :status)
  end
end
