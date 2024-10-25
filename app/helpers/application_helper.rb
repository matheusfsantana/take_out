module ApplicationHelper
  def has_restaurant?
    Restaurant.exists?(user: current_user)
  end

  def user_restaurant
    Restaurant.find_by(user: current_user)
  end
end
