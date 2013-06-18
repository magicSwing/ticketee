class ProjectsController < ApplicationController
  before_filter :authorize_admin!, :except => [:index, :show]
  before_filter :find_project, :only =>  [:show,
                                          :edit,
                                          :update,
                                          :destroy]
  
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash[:alert] =  "Project has not been created."
      render :action => "new"
    end
  end

  def edit
    #这里如果我使用的是@project = Project.new(params[:project]),而不是@project = Project.find(params[:id])
    #貌似rails会自动认为你在创建
    #资源，会自觉跳转到create，而不是update，并且form表单的name不显示（其实参数已经有了），
    #form表单的提交显示的也是create project
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project has been deleted."
    redirect_to projects_path
  end

  def show
  end

  private
  def find_project
    @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking" +
                    " for could not be found."
    redirect_to projects_path
  end

end
