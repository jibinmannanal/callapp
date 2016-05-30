require "bunny"
class API::V1::ContactsController < ApplicationController
  before_action :set_contact, only: [ :edit, :update, :destroy]
  respond_to :json
  # GET /contacts
  # GET /contacts.json
  def index
    @org5= Contact.select("*").joins(:client)
    respond_with @org5
  end

  # GET /contacts/1
  # GET /contacts/1.json

    def show

      conn = Bunny.new
      conn.start
      ch   = conn.create_channel
      q    = ch.queue("hello")
      puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
      q.subscribe(:block => true) do |delivery_info, properties, body|
        puts " [x] Received #{body}"
        # cancel the consumer to exit
        @q= body
        delivery_info.consumer.cancel

      end

      @org1=Contact.where(:phone_number=>@q)
       @org5= Contact.select("*").joins(:organization)
       @org6=@org5.where(:phone_number=>params[:phone_number])
       @org7= Organization.select('*').joins(:comments, :contacts)
      @org8= @org7.where(:id=>@org1)
respond_with @org8

      conn = Bunny.new
      conn.start
      ch   = conn.create_channel
      q    = ch.queue(@q)
      x    = ch.fanout(@q)
     q.publish(@org8.to_json)
      puts " [x] Sent #{@org8}"
      conn.close


    end
  def show1


    @org5= Contact.select("*").joins(:client)
    respond_with @org6=@org5.where(:phone_number=>params[:phone_number])


  end

  # GET /contacts/new
  def new

    @contact = Contact.new

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
    @contact =Contact.find_by_phone_number contact_params[:phone_number]
    if @contact
      @contact.update(contact_params)
      redirect_to organization_contact_path(@contact.organization_id,@contact), notice: 'Contact was successfully updated.'
    else
      @contact = Contact.new(contact_params)

      respond_to do |format|
        if @contact.save
          format.html { redirect_to organization_contact_path(@contact.organization_id,@contact), notice: 'Contact was successfully created.' }

          format.json { render :show, status: :created, location: @contact }
        else
          format.html { redirect_to new_organization_contact_path(@contact.organization_id), notice: 'E-mail or phonenumber incorrect' }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
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
    params.require(:organization).permit(:id, :organization_name,  :phone_number, :address)
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:id, :organization_id, :phone_number)
    end
  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    params.require(:client).permit(:id, :client_id, :organization_id ,:name, :client => [])
  end

end
