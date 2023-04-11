class CoursesController < ApplicationController
    before_action :set_course, only: [:show, :edit, :update, :destroy]
  
    def index
      @courses = Course.all
    end
  
    def show
    end
  
    def new
      @course = Course.new
    end
  
    def create
      debugger
      @course = Course.new(course_params)
  
      if @course.save
        flash[:notice] = "Course created successfully"
        redirect_to @course
      else
        flash[:alert] = "Error creating course: #{@course.errors.full_messages.to_sentence}"
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @course.update(course_params)
        flash[:notice] = "Course updated successfully"
        redirect_to @course
      else
        flash[:alert] = "Error updating course: #{@course.errors.full_messages.to_sentence}"
        render :edit
      end
    end
  
    def destroy
      @course.destroy
      flash[:notice] = "Course deleted successfully"
      redirect_to courses_path
    end
  
    private
  
    def set_course
      @course = Course.find(params[:id])
    end
  
    def course_params
      params.require(:course).permit(:title, :description, :image)
    end
  end
  