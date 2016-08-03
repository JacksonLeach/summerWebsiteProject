class SchoolClassController < ApplicationController
	helper_method :get_tag_list, :remove_user, :remove_qset
	def new
		parmas[:page_header] = "New Class"
		@school_class = SchoolClass.new
	end
	def create
		@school_class = SchoolClass.new(school_class_params)
		@school_class.teacher_id = current_user.id
		if @school_class.save
			flash[:notice] = "Class created successfully! Class code is " + @school_class.id.to_s
			redirect_to '/class'
		else
			render 'new'
		end
	end
	def index
		params[:page_header] = "Your classes"
		@school_classes = SchoolClass.all
	end
	def signup_start
		params[:page_header] = "Signup for class"
	end
	def signup_confirm
		params[:page_header] = "Signup for class"
		@school_class = SchoolClass.find(params[:signup_code])
		@ids = Array.new
		@school_class.users.each do |u|
			@ids << u.id
		end
		if @ids.index(current_user.id) == nil
			@school_class.users << current_user
			flash[:notice] = "You have signed up for class #{@school_class.name}"
		else
			flash[:error] = "You are already signed up for that class"
		end
	end
	def edit
		params[:page_header] = "Edit class"
		@school_class = SchoolClass.find(params[:id])
		@users = @school_class.users
		@qsets = @school_class.qsets
		@new_qsets = current_user.qsets

	end
	def show
		params[:page_header] = "Class details"
		@school_class = SchoolClass.find(params[:id])
		@users = @school_class.users
		@qsets = @school_class.qsets
	end
	def get_tag_list(qset)
		return_array = Array.new
		qset.questions.each do |q|
			if return_array.index(q.tag) == nil
				return_array << q.tag
			end
		end
		return return_array
	end
	def update
		flash[:notice] = Array.new
		@school_class = SchoolClass.find(params[:id])
		if params["update_data"]["remove_user"] != nil
			params["update_data"]["remove_user"].each do |key, value|
				if value.to_i == 1
					remove_user(key)
					user = User.find(key)
					flash[:notice] << "User #{user.first_name} #{user.last_name} removed from class"
				end
			end

		end
		if params["update_data"]["add_qset"] != nil
			params["update_data"]["add_qset"].each do |key, value|
				if value.to_i == 1
					@school_class.qsets << Qset.find(value)
					flash[:notice] << "Question set #{Qset.find(value).name} added to class"
				end
			end
		end
		if params["update_data"]["remove_qset"] != nil
			params["update_data"]["remove_qset"].each do |key, value|
				if value.to_i == 1
					remove_qset(key)
					flash[:notice] << "Question set #{Qset.find(value).name} removed from class"
				end
			end
		end
		redirect_to school_class_show_path(@school_class.id)
	end
	def remove_user(id)
		u = User.find(id)
		@school_class.users.delete(u)
	end
	def remove_qset(id)
		q = Qset.find(id)
		@school_class.qsets.delete(q)
	end
	private
	def school_class_params
		params.require(:school_class).permit(:name, :teacher)
	end
end
