module ApplicationHelper
  def has_restaurant?
    current_user.restaurant != nil
  end

  def user_restaurant
    current_user.restaurant
  end
end
