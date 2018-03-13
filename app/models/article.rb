class Article < ApplicationRecord
validates_presence_of :title, :body, :category_id, :publish_date, :feature_image_url
validates_length_of :body, minimum: 5
validate :publish_date_is_not_greater_than_todays_date
belongs_to :category
belongs_to :user
has_many :reviews
private

def publish_date_is_not_greater_than_todays_date
	if (publish_date > Date.today + 30.days)
		errors.add(:publish_date, 'must not be greater than 1 month')
	end

end	
end
