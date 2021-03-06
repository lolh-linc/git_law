class GitlabClientIdentitiesController < ApplicationController
  before_action :authenticate_user!

  expose :user do
    User.find params[:user_id]
  end

  expose :gitlab_client_identity do
    if params[:id]
      GitlabClientIdentity.find params[:id]
    else
      identity_request.build_gitlab_client_identity gitlab_client_identity_params
    end
  end

  expose( :unpaginated_gitlab_client_identities ) do
    s = user.gitlab_client_identities
    s = s.order :host, :gitlab_user_id
  end

  expose :identity_request do
    GitlabClientIdentityRequest.find params[:gitlab_client_identity_request_id]
  end

  expose :new_gitlab_client_identity do
    user.gitlab_client_identities.build
  end

  helper_method :gitlab_client_identities

  def create
    authorize gitlab_client_identity, :create?
    if gitlab_client_identity.save
      render 'show', status: 201
    else
      render 'errors', status: 422
    end
  end

  def index
    authorize new_gitlab_client_identity, :index?
    if page == 1 || gitlab_client_identities.any?
      render status: 200
    else
      render nothing: true, status: 404
    end
  end

  def destroy
    authorize gitlab_client_identity, :destroy?
    if gitlab_client_identity.destroy
      render nothing: true, status: 204
    else
      render nothing: true, status: 500
    end
  end

  private

  def authorize_user!
    if params[:id]
      authorize gitlab_client_identity
    else
      authorize GitlabClientIdentity.new user: user
    end
  end

  def gitlab_client_identity_params
    params.permit(:code)
  end

  def gitlab_client_identities
    @gitlab_client_identities ||= paginate unpaginated_gitlab_client_identities
  end
end
