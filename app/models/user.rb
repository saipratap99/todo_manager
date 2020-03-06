class User < ActiveRecord::Base
  def to_pleasant_string
    "#{id}. Name:#{name} Email:#{email} Password:#{password}"
  end
end
