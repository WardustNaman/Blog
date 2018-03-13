class ArticlesController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
load_and_authorize_resource
def index
	@articles = Article.paginate(:page => params[:page], :per_page => 6)
	@article = Article.new
	@category = Category.new
end
def new
	@article = Article.new
end
def create
	@article = Article.new(article_params)
	@article.user_id = current_user.id
	if @article.publish_date <= Date.today
		@article.is_published = true
	else
		@article.publish_date > Date.today
		@article.is_published = false
	end
	if @article.save
		redirect_to articles_path(@article.id), notice: "Article was successfully created"
	else
		render action: 'new'
end
end
def show 
	@article = Article.find(params[:id])
	@review = Review.new
end
def edit
	@article = Article.find(params[:id])
end
def update
	@article = Article.find(params[:id])
	@article.user_id = current_user.id
	if @article.update_attributes(article_params)
		redirect_to articles_path(@article.id), notice: "The article was successfully updated"
	else
		render action:"edit"
	end
end
def destroy
	@article = Article.find(params[:id])
	@article.destroy
		redirect_to articles_path, notice: "The article was successfully deleted"	
end

def check_name_present
		@article = Article.find_by(title: params[:title])
	    render json: @article.nil? ? {'msg': 'can be used'} : {'msg': 'already taken'}   
	end

private

def article_params
	params[:article].permit(:user_id, :title, :body ,:category_id, :publish_date, :feature_image_url, :cover, :is_published)
end
end
