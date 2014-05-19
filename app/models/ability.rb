class Ability
  include CanCan::Ability

  def initialize(current_user)
    can :manage, :all if current_user.admin? unless current_user.nil?
  end
end
