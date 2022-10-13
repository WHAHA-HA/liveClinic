class User < ActiveRecord::Base
  # Include default devise modules.

  # mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable

  belongs_to :owner, :polymorphic => true
  belongs_to :user_profile

  include DeviseTokenAuth::Concerns::User

  # User Avatar Validation
  # validates_integrity_of  :avatar
  # validates_processing_of :avatar

  # validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
  # validates :password, presence: true, on: :update, allow_blank: true
  # validates :password_confirmation, on: :update, allow_blank: true

  before_save -> do
    self.uid = SecureRandom.uuid
    skip_confirmation!
  end

  def is_doctor?
    (self.owner_type == "Doctor")
  end

  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
