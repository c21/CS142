class Comment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user

  def validate_comment
    if comment.nil? || comment.empty?
      errors.add(:comment, "connot be empty")
    end
  end

  validate :validate_comment
end
