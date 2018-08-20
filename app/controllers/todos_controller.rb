class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  attr_accessor :app_title
  attr_accessor :current_app_title
  
  def currentapp_initialize
    @app_title = "GM-Inc. App Center" #BootstrapApp
    @current_app_title = "GM-Todo"
  end

  # GET /todos
  # GET /todos.json
  def index

    currentapp_initialize


    ############ INIT pagination variables ##########################
    @pageflag = true
    @countflag = false
    @current_page = 1
    @next_page = 1
    @prev_page = 1
    @nb_page_display = 5
    @nb_page_To_display = 1

    @prev_page_flag = false
    @next_page_flag = false
    
    defaultpage = 1
    defaulcount = 5


    ############ Retrieving of count and page params ################
    if params[:page].present?
      @page = params[:page].to_i
      if @page < 0
        @page = defaultpage
      end
    else
      @page = defaultpage
    end

    if params[:count].present?
      @count = params[:count].to_i
      if @count < 0
        @count = defaulcount
      end
    else
      @count = defaulcount
    end


    ############ Calcul next and prev pagination ####################
    @allRecordData = Todo.count
    @nb_page_To_display = (@allRecordData/@count.to_f).ceil
    @ffset = (@page-1)*@count
    if (@ffset + @count) > @count
      @prev_page_flag = true
    end

    if (@ffset + @count) < @allRecordData
      @next_page_flag = true
    end

    @todos = Todo.limit(@count).offset(@ffset)

  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    currentapp_initialize
  end

  # GET /todos/new
  def new
    currentapp_initialize
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
    currentapp_initialize
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:title, :notes, :deadline, :time)
    end
end
