class Ability
  include CanCan::Ability

  def initialize(current_user)
    can :manage, :all if current_user && current_user.admin?
  end
end
