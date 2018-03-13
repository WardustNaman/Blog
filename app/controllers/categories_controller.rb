class CategoriesController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :authenticate_user!, except: [:index, :show]
	load_and_authorize_resource

	def index
		@categories = Category.all
	end
	def new
		@category = Category.new
	end
	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to categories_path(@category.id), notice: "The category was successfully updated"
		else
			render action: 'new'
		end
	end
	def show
		@category = Category.find(params[:id])
	end
	def edit
		@category = Category.find(params[:id])
	end
	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_params)
			redirect_to categories_path(@category.id), notice: "The category was successfully updated"
		else
			render action: "edit"
		end
	end
	def destroy
		@category = Category.find(params[:id])
		@category.destroy
			redirect_to categories_path, notice: "The category was successfully updated"
	end

	def check_name_present
		category = Category.find_by(name: params[:name])
	    render json: category.nil? ? {'msg': 'can be used'} : {'msg': 'already taken'}   
	end

	private

	def category_params
		params[:category].permit(:name, :description)
	end
end