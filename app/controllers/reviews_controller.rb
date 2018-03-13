class ReviewsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
load_and_authorize_resource

def create
	@review = Review.new(review_params)
	@review.user_id = current_user.id
	if @review.save
		redirect_to article_path(@review.article_id), notice: "Thank you for adding a review. "
	end
end
def show 
	@review = Review.find(params[:id])
	@article = Article.find(@review.article_id)
end
def edit
	@review = Review.find(params[:id])
end	
def destroy 
@review = Review.find(params[:id])
@review.destroy
     redirect_to article_path(@review.article_id), notice: "The review was successfully deleted"
end 
def update
	@review = Review.find(params[:id])
	@review.user_id = current_user.id
	if @review.update_attributes(review_params)
		redirect_to review_path(@review.id), notice: "The review was successfully updated"
	end
end

private
 def review_params
     params[:review].permit(:body, :rating, :article_id)
end
end
