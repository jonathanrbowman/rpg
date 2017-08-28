class Character < ActiveRecord::Base
  belongs_to :user, optional: true
  validates :name, uniqueness: { scope: :user_id }
end
