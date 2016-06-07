class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    status = true
    params[:task][:list_id].length.times do |index, value|
      @task = Task.new(list_id: params[:task][:list_id][index],
        name: params[:task][:name][index], 
        description: params[:task][:description][index])
      if !@task.save
        status = false
        @task.errors[:base] << "Unable to save task."
      end
    end

    respond_to do |format|
      if status
        format.js { flash[:notice] = 'Task was successfully created.' }
      else
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /tasks/1
  def update
    respond_to do |format|
      if @task.update(list_id: params[:task][:list_id].first,
        name: params[:task][:name].first, 
        description: params[:task][:description].first)
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
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(name: [], description: [], list_id: [] )
    end
end
