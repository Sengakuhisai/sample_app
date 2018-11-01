# == Schema Information
#
# Table name: microposts
#
#  id          :integer          not null, primary key
#  content     :text
#  in_reply_to :string
#  picture     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#

class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id,presence: true
  validates :content,presence: true,length: {maximum:140}
  validate :picture_size

  before_validation :confirm_reply_id
  validate :reply_id_invalid?
  
  
  private
  
    #アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture,"should be less than 5MB")
      end
    end
    
    def confirm_reply_id
      if self.content.match(/@\d+/).present?
        rep_id=self.content.match(/@\d+/)[0][/\d+/].to_i
        self.in_reply_to=rep_id
      else
        self.in_reply_to=self.user.id
      end
    end
    
    def reply_id_invalid?
      unless User.select("id").exists?(:id => self.in_reply_to)
          errors.add(:in_reply_to,"this ID is unable.The ID is not exists.")
      end
    end

end
