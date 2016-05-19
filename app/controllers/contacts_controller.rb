class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    @organization = Organization.find(params[:organization_id])
    @client = Client.find(params[:client_id])
    @contact = Client.find(params[:client_id])
    @contacts = Contact.where(:client_id => @contact)
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @organization = Organization.find(params[:organization_id])
    @client = Client.find(params[:client_id])
    @contact = Contact.find(params[:id])
  end

  # GET /contacts/new
  def new

    @contact = Contact.new
    @client = Client.find(params[:client_id])
    @organization = Organization.find(params[:organization_id])

  end

  # GET /contacts/1/edit
  def edit
    @organization = Organization.find(params[:organization_id])
    @client = Client.find(params[:client_id])
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to organization_client_contacts_path(@contact.organization_id,@contact.client_id), notice: 'Contact was successfully created.' }

        format.json { render :show, status: :created, location: organization_client_contact_path }
      else
        format.html { redirect_to new_organization_client_contact_path(@contact.organization_id,@contact.client_id), notice: 'E-mail or phonenumber incorrect' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end
  def organization_params
    params.require(:organization).permit(:id, :organization_name, :email, :phone_number, :address)
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:client_id, :organization_id,:email, :phone_number)
    end
  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    params.require(:client).permit(:id, :client_id, :organization_id ,:name, :client => [])
  end

end
