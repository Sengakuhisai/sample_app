class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id,presence: true
  validates :content,presence: true,length: {maximum:140}
  validate :picture_size

  before_create :confirm_reply_id
  
  private
  
    #アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture,"should be less than 5MB")
      end
    end
    
    def confirm_reply_id
      if self.content.index("@").present?
        rep_id=self.content.match(/@\d+/)[0][/\d+/].to_i
        unless User.select("id").exists?(id==rep_id)
          errors.add(:in_reply_to,"This reply id is not exists.")
        end
      end
    end
  
end
