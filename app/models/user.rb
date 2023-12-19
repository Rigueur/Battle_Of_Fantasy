class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :towns
  has_many :messages
  validates :username, :nickname, :level, :experience, :energy, presence: true
  validates :username, uniqueness: true

  after_create :set_energy_updated_at

  def set_energy_updated_at
    self.update(energy_updated_at: 0.minutes.from_now)
  end
end
