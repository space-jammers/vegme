class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :assign_admin

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes
  has_many :feedbacks

  def disliked_recipes
    recipes.where(dislike: true).select('edamam_id').map(&:edamam_id).to_a
  end

  def assign_admin
    update(admin: true) if email == ENV['hm_email']
    update(admin: true) if email == ENV['ld_email']
  end
end
