class Article < ApplicationRecord
  validates :title, :body, presence: true
  has_many :comments, dependent: :destroy

  default_scope { order(created_at: :desc)}

  belongs_to :user
end
