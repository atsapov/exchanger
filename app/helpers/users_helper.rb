module UsersHelper

  def admin_user
    @admin_user = User.find_by_admin(true)
  end
end
