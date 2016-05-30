class API::V1::StaticPagesController < ApplicationController
  respond_to :json
   def phone_number
    @request = Request.new(params[:phone_number])

    respond_to do |format|
      if @request.save
        @keywords = params[:phone_number]
        @found_phone = Contact.where( :phone_number=> @keywords ).first
          @org=@found_phone.organization_id
          @org1=Organization.where(:id=> @org).first
          @org3=@org1.organization_name
          render json: @org3
        format.json  { render :json => @request, :status => :created, :location => @request }
      else

        format.json  { render :json => @request.errors, :status => :unprocessable_entity }
      end
      end
    end

    def  phone_number_results
      @request = Request.find(params[:phone_number])
      respond_to do |format|
        format.json {render :@request.to_json}
      end

end

end
