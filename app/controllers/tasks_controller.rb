class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_type
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = type_class.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = type_class.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = type_class.new(task_params)
    @father_task = Task.where(id: @task.index_task)
    @task.list_id = @father_task.first.list_id

    respond_to do |format|
      if @task.save
        format.js { flash[:notice]='Task was successfully created.' }
      else
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.js { flash[:notice]='Task was successfully updated.'}
      else
        format.js { render :edit }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = type_class.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(type.underscore.to_sym).permit(:name, :description, :list_id, :type, :index_task)
    end

    def set_type
      @type = type
    end
 
    def type 
      Task.types.include?(params[:type]) ? params[:type] : "Task"
    end
 
    def type_class 
      type.constantize 
    end
end
