class API::V1::ClientsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :json

 def index
    @client = Client.all
    respond_to do |format|
      format.json { render :json => @client }
    end
  end

  def new
    respond_with Client.new
  end

  def show
    respond_with Client.find(params[:id || :name])
   end

  def create

    respond_with Client.create(client_params)

  end

  def update
    respond_with Client.update(params[:id], params[:name])
  end

  def destroy
    respond_with Client.destroy(params[:id])
  end
  def client_params
    params.permit(:id, :name, :organization_id ,:phone_number, :client => [])
  end
end
