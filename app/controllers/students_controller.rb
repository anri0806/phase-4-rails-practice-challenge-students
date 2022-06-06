class StudentsController < ApplicationController

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = Student.find_by(id: params[:id])

        if student
            render json: student, status: :ok
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def create 
        # instructor = Instructor.find_by(id: params[:id])
        # student = instructor.students.create(student_params)
        student = Student.create(student_params)

        if student.valid?
            render json: student, status: :created
        else
            render json: {error: "not valid"}, status: :unprocessable_entity
        end
    end

    def update
        student = Student.find_by(id: params[:id])
        
        if student
            student.update(student_params)
            render json: student, status: :ok
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    def destroy
        student = Student.find_by(id: params[:id])

        if student
            student.destroy
            head :no_content
        else
            render json: {error: "student not found"}, status: :not_found
        end
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

end
