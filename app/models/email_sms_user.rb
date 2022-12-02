class EmailSmsUser < User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   devise :database_authenticatable, :registerable,
#          :recoverable, :rememberable, :validatable
  validates :full_phone_number, uniqueness: true
  has_many :otps, dependent: :destroy, foreign_key: :user_id
end
