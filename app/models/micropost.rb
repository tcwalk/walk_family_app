class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  validate  :picture_size
#  validate  :picture_type

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def picture_type
    if !(picture.blank?) && !(picture.to_s =~ /jpg$/) && !(picture.to_s =~ /jpeg$/) && !(picture.to_s =~ /png$/) && !(picture.to_s =~ /gif$/)
      errors.add(:picture, "is not a valid file. Only jpg, jpeg, gif, and png files are allowed")
    end
  end


end
