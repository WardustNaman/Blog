class Ability
  include CanCan::Ability
 # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
 
  def initialize(user)
    if user.nil?
        can :read, [Category, Article]
    elsif user.role?"admin"
        can :manage, [Category, Article, Review]
    elsif user.role?"moderator"
        can :read, [Category, Article, Review]
        can :create, Review
        can :destroy, Review
    elsif user.role?"author"
        can :read, [Category, Article, Review]
        can :create, [Article, Review] 
        can [:update, :destroy], Article do |art|
            art.article.user_id == user.id
        end
        can :destroy, Review do |rev|
            rev.article.user_id == user.id
        end
    elsif user.role?"user"
        can :read, [Category, Article, Review]
        can [:read, :create], Review
        can [:update, :destroy], Review do |review|
            review.user_id == user.id
        end
    end
        
  end
end
