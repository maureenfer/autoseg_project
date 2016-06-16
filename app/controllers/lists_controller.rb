class ListsController < ApplicationController
  include ActionController::Live

  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def notification
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'

    sse = SSE.new(response.stream)

    last_updated = List.last_updated.first
    if recently_changed? last_updated
      begin
        sse.write(last_updated, event: 'results')
      rescue IOError
        # When the client disconnects, we'll get an IOError on write
      ensure
        sse.close
      end
    end
  end

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
    @list.tasks.build
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = current_user.lists.new(list_params)

    respond_to do |format|
      if @list.save
        format.js { flash[:notice]='List was successfully created.' }
      else
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.js { flash[:notice]='List was successfully updated.'}
      else
        format.js { render :edit }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
    end
  end

  private
    def recently_changed? last_list
      last_list.created_at > 5.seconds.ago or
        last_list.updated_at > 5.seconds.ago
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name, :status, :user_id, 
        tasks_attributes:[:id, :name, :description, :_destroy])
    end
end
