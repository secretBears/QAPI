class Ability
  include CanCan::Ability

  def initialize(current_user)
    unless current_user.nil?
      if current_user.admin?
        can :manage, :all
      end
    end
  end
end
