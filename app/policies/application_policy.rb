# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # def index?
  #   false
  # end

  # def show?
  #   false
  # end

  # def create?
  #   false
  # end

  # def new?
  #   create?
  # end

  # def update?
  #   user_admin?
  # end

  # def edit?
  #   update?
  # end

  # def destroy?
  # end

  def user_admin?
    user.admin?
  end

  def user_manager?
    user.manager?
  end

  def user_accountant?
    user.accountant?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
