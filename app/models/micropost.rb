class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  private
# Проверяет размер выгруженного изображения.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
  end



#     belongs_to       :user
#     has_one_attached :image
#     default_scope -> { order(created_at: :desc) }
#     validates :user_id, presence: true
#     validates :content, presence: true, length: { maximum: 140 }
#     validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
#                                       message: "must be a valid image format" },
#                       size: { less_than: 5.megabytes,
#                               message: "should be less than 5MB" }
                      
#     # Returns a resized image for display.
#     def display_image
#       image.variant(resize_to_limit: [500, 500])
#     end
# end
