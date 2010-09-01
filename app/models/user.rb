class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  field :name, :type => String
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable 
         #:recoverable, :rememberable, :trackable, :validatable

end
