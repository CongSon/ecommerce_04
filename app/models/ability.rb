class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "admin"
      can :manage, :all
    when "user"
      can :read, [Category, Product, Comment, Rate, Order, OrderDetail,
        Specification, User]
      can :create, [Comment, Rate, Order, OrderDetail]
      can :update, [Comment, Rate]
    else
      can :read, [Category, Product, Comment, Rate, Order, OrderDetail,
        Specification, User]
    end
  end
end
