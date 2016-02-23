class JurisdictionsController < ApiController
  before_filter :decamelize_params!
  expose :jurisdiction
  expose( :unpaginated_jurisdictions ) { Jurisdiction.order(:name) }
  helper_method :jurisdictions

  def index
    render status: 200
  end

  def show
    render status: 200
  end

  def create
    jurisdiction.attributes = jurisdiction_params
    if jurisdiction.save
      render 'show', status: 201
    else
      render 'errors', status: 422
    end
  end

  def update
    jurisdiction.attributes = jurisdiction_params
    if jurisdiction.save
      render nothing: true, status: 204
    else
      render 'errors', status: 422
    end
  end

  def destroy
    if jurisdiction.destroy
      render nothing: true, status: 204
    else
      render nothing: true, status: 500
    end
  end

  private

  def jurisdictions
    @jurisdictions ||= paginate unpaginated_jurisdictions
  end

  def jurisdiction_params
    @jurisdiction_params ||= params.
      permit(:name)
  end
end
