module ApplicationHelper
  def has_restaurant?
    current_user.restaurant != nil
  end

  def user_restaurant
    current_user.restaurant
  end

  def format_date_to_brasilia(datetime, format = '%d/%m/%Y %H:%M')
    return nil if datetime.blank?

    datetime.in_time_zone('Brasilia').strftime(format)
  end
end
