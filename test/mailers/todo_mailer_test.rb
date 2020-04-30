require 'test_helper'

class TodoMailerTest < ActionMailer::TestCase
  test "upcoming_todo" do
    mail = TodoMailer.upcoming_todo
    assert_equal "Upcoming todo", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
