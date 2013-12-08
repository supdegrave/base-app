class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :invitable, 
          :database_authenticatable, 
          :registerable, 
          :confirmable,
          :recoverable, 
          :rememberable, 
          :trackable, 
          :validatable
          
  validates_presence_of :first_name,  :last_name
  
  def name 
    "#{first_name} #{last_name}"
  end
end
