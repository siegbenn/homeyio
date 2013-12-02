class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    end
    if user.user?
     can :read, :all
     can :create, Home
     can :update, Home do |home|
        home && home.user_id == user.id
     end
     can :destroy, Home do |home|
        home && home.user_id == user.id
     end
    end
  end
end
