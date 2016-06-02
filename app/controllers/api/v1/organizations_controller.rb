class API::V1:: OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organization = Organization.all
    respond_to do |format|
      format.json { render :json => @organization }
    end
  end

  def new
    respond_with Organization.new
  end

  def show
    respond_with Organization.find(params[:id || :name])
  end

  def create

    respond_with Organization.create(client_params)

  end

  def update
    respond_with Organization.update(params[:id], params[:name])
  end

  def destroy
    respond_with Organization.destroy(params[:id])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organization
    @organization = Organization.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organization_params
    params.require(:organization).permit(:organization_name, :email, :phone_number, :address)
  end
end
