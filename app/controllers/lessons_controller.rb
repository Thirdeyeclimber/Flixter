class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_enrollment_for_current_lesson, only: [:show]

	def show
		@lesson = current_lesson
	end

	private

	def require_enrollment_for_current_lesson
	 	unless current_user.enrolled_in?(current_lesson.section.course)
	  	redirect_to courses_path, alert: 'Must be enrolled to access'
	  end
	end

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end
end
