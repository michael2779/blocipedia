class WikiPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    true
  end

  def update?
   @user.present?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []

      if user.role == 'admihn'
          wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all

        all_wikis.each {|a_wiki|
          if a_wiki.private == false || a_wiki.user == user    # || a_wiki.collaborators.include?(user)
            wikis << a_wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        }
      else
        all_wikis = scope.all

          all_wikis.each {|a_wiki|
            if a_wiki.private == false
              wikis << a_wiki
            end
          }
      end

      return wikis

    end
  end


end
