class User < ActiveRecord::Base
  has_many :todos, dependent: :destroy

  def to_pleasant_string
    "#{id}. Name:#{name} Email:#{email} Password:#{password}"
  end

  def self.check_crendentials(email, password)
    where("email=? and password=?", email, password).exists?
  end
end
