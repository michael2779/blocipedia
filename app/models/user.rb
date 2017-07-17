class User < ApplicationRecord
  has_many :collaborators
  has_many :wikis, through: :collaborators

    enum role: [:standard, :premium, :admin]
    after_initialize :set_default_role, :if => :new_record?

    def set_default_role
      self.role ||= :standard
    end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


end
