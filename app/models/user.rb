class User < ActiveRecord::Base
  has_secure_password
  has_many :todos, dependent: :destroy
  validates :first_name, :password, presence: true, length: { in: 3..50 }
  validates :email, presence: true, uniqueness: true

  def to_pleasant_string
    "#{id}. Name:#{name} Email:#{email} Password:#{password}"
  end

  def self.check_crendentials(email, password)
    where("email=? and password=?", email, password).exists?
  end
end
