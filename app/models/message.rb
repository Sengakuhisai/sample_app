# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  from_id    :integer
#  to_id      :integer
#
# Indexes
#
#  index_messages_on_from_id                 (from_id)
#  index_messages_on_from_id_and_created_at  (from_id,created_at)
#  index_messages_on_to_id                   (to_id)
#  index_messages_on_to_id_and_created_at    (to_id,created_at)
#

class Message < ApplicationRecord
  belongs_to :sentmsg,class_name: "User",optional: true
  belongs_to :gotmsg,class_name: "User",optional: true
  default_scope -> {order(created_at: :desc)}
  validates :from_id,presence: true
  validates :to_id,presence: true
  validates :content,presence: true,length: {maximum:500}
end
