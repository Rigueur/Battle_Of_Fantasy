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
  validates :username, uniqueness: true

  after_create :set_energy_updated_at

  def set_energy_updated_at
    self.update(energy_updated_at: 0.minutes.from_now)
  end

  def xp_gain(xp)
    xp_needed = self.level * 20 + 80
    if self.experience + xp >= xp_needed
      self.update(level: self.level + 1, experience: self.experience + xp - xp_needed, energy: self.energy + 50)
      return "Level up! - Energy + 50"
    else
      self.update(experience: self.experience + xp)
      return "Experience + #{xp}"
    end
  end
end
