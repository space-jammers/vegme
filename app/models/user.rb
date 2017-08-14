class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :recipes

  def disliked_recipes
    recipes.where(dislike: true).select('edamam_id').map(&:edamam_id).to_a
  end
end
