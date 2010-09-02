#coding:utf-8
class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  field :nickname, :type => String
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :nickname
  validates_format_of :nickname, :with => /^\w+$/, 
                      :on => :create, :message => "用户名错误"
  validates_uniqueness_of :nickname, 
                          :case_sensitive => false, :message => '此昵称已被占用'
end
