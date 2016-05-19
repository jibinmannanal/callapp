class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @organization = Organization.find(params[:organization_id])
    @clients = Client.where(:organization_id => @organization)
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @organization = Organization.find(params[:organization_id])
    @comments = @client.comments

    @comment = @client.comments.build
    @feed_items = @client.feed.paginate(page: params[:page], :per_page => 5)
    @c=@organization.organization_name
  end

  # GET /clients/new
  def new
    @client = Client.new
    @organization = Organization.find(params[:organization_id])
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    @organization = Organization.find(params[:organization_id])
  end

  # POST /clients
  # POST /clients.json
  def create

    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to organization_clients_path(@client.organization_id), notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: organization_clients_url  }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to URI(request.referer).path, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:organization_id ,:name, :client => [])
    end
  def organization_params
    params.require(:organization).permit(:id, :organization_name, :email, :phone_number, :address)
  end
end
