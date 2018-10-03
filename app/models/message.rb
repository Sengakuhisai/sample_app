class Message < ApplicationRecord
  belongs_to :sent_msg,class_name: "User"
  belongs_to :got_msg,class_name: "User"
  default_scope -> {order(created_at: :desc)}
  validates :to_id,presence: true
  validates :content,presence: true,length: {maximum:500}
end
