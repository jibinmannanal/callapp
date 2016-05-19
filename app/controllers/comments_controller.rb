class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @client = Client.find(params[:id])
    @organization = Organization.find(params[:organization_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @client = Client.find(params[:client_id])
    @organization = Organization.find(params[:organization_id])
  end

  # POST /comments
  # POST /comments.json
  def create

    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        Publisher.publish("comments", @comment.attributes)
        format.html { redirect_to organization_client_path(@comment.organization_id,@comment.client_id), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: organization_client_path(@comment.organization_id,@comment.client_id)  }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to organization_client_path(@comment.organization_id,@comment.client_id), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to URI(request.referer).path, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :client_id, :organization_id)
    end
  def correct_user
    @client = Client.find(params[:id])

  end
end
