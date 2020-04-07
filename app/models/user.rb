class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :encrypted_password,length: { minimum: 7 }
  validates :nickname, presence: true


  has_one :profile
  has_one :ship
end
