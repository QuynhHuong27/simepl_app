class Micropost < ApplicationRecord
  MICROPOSTS_PARAMS = %i(content image).freeze

  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, length: { maximum: 500 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
    message: "must be a valid image format" },

    size: { less_than: 5.megabytes,

    message: "should be less than 5MB" }

  delegate :name, to: :user, prefix: true

  scope :order_micropost, -> { order(created_at: :desc) }
  scope :user_feed, -> id { where user_id: id }
end
