class StudentsController < ApplicationController
    before_action :set_student, only: [:show, :edit, :update, :destroy]
  
    def index
      @students = Student.all
    end
  
    def show
    end
  
    def new
      @student = Student.new
    end
  
    def create
      @student = Student.new(student_params)
  
      if @student.save
        flash[:notice] = "Student created successfully"
        redirect_to @student
      else
        flash[:alert] = "Error creating student: #{@student.errors.full_messages.to_sentence}"
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @student.update(student_params)
        flash[:notice] = "Student updated successfully"
        redirect_to @student
      else
        flash[:alert] = "Error updating student: #{@student.errors.full_messages.to_sentence}"
        render :edit
      end
    end
  
    def destroy
      @student.destroy
      flash[:notice] = "Student deleted successfully"
      redirect_to students_path
    end
  
    private
  
    def set_student
      @student = Student.find(params[:id])
    end
  
    def student_params
      params.require(:student).permit(:name, :surname, :second_surname, :email, :wallet_address)
    end
  end
  