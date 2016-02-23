class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # for guest

    unless user.id

      # Guest Users
      can [:show, :index], :all
    else

      # Registered Users

      can :manage, Post do |post|
        post.user == user
      end

      can [:create], Comment

      can [:destroy], Comment do |comment|
        comment.user == user || comment.post.user == user
      end


      ## Post owner can't favorite their own Post



      if user.admin?
        can :manage, :all
      end
    end


  end
end
