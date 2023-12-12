class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :towns
  has_many :messages_as_sender, class_name: 'Message',
  foreign_key: :sender_id
  has_many :messages_as_receiver, class_name: 'Message',
  foreign_key: :receiver_id
  validates :username, :nickname, :level, :experience, :energy, presence: true
end
