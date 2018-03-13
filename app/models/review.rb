class Review < ApplicationRecord
validates_presence_of :body, :article_id, :rating, :user_id
validates_length_of :body, within: 10...1000
belongs_to :article
belongs_to :user
end


