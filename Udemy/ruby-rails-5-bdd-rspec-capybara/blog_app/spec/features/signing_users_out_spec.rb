require "rails_helper"

RSpec.feature "Users Signin" do

  before do
    @user = User.create!(email: 'user@example.com', password: 'password')
  end

end