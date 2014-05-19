class Admin < User
  def admin?
    type == "Admin"
  end
end
