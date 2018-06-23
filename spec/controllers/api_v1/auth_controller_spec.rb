require "rails_helper"
require "spec_helper"

RSpec.describe ApiV1::AuthController, type: :controller do

  describe "user's login and logout operation" do

    let(:user) { User.create!(:email => 'joy2222@gmail.com', :password => 'aaaaaaa', :schoolid => "34343434") }

    context "user login" do

      it "send account & password to controller" do

        post :login, params: { email: user.email , password: user.password }

        parameter = JSON.parse(response.body)

        expect(parameter['message']).to eql("Ok")

      end

    end

  end

end
