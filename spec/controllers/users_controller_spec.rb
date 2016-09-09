require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    it "First name must be present" do
      user  = User.new
      user.valid?
      expect(user.errors.messages).to have_key(:first_name)

    end

    it "fullname " do
      u = User.new FactoryGirl.attributes_for(:user).merge({first_name: "John", last_name: "Smith"})
      expect(u.full_name).to eq("John Smith")
    end
  end

end
