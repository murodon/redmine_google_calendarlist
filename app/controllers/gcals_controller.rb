class GcalsController < ApplicationController
  unloadable
  menu_item :google_calendarlist
  before_filter :find_project, :authorize
  before_filter :find_gcal, :except => [:index, :new, :create, :preview]

  def index
     @gcals = Gcal.find(:all, :conditions => ["project_id = #{@project.id} "])
  end

  def new
     @gcal = Gcal.new()
  end

  def show
  end

 def update
    @gcal.attributes = params[:gcal]
    if @gcal.save
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_gcal_path(@project, @gcal.id)
    end
  rescue ActiveRecord::StaleObjectError
    flash.now[:error] = l(:notice_locking_conflict)
  end

  def edit
  end


  def create
    @gcal = Gcal.new(params[:gcal])
    @gcal.project_id = @project.id

    if @gcal.save    
      flash[:notice] = l(:notice_successful_create)
      redirect_to project_gcal_path(@project, @gcal.id)
    end
  end

  def destroy
    @gcal.destroy
    redirect_to project_gcals_path(@project)
  end

  def preview
    @text = params[:gcal][:description]
    render :partial => 'common/preview'
  end


private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end 

  def find_gcal
    @gcal = Gcal.find_by_id(params[:id])
    render_404    unless @gcal
  end

end
