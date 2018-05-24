require 'rails_helper'

RSpec.describe PersonalInfor do

  context "when a person is a student" do

    before(:all) do
        @personal_info = PersonalInfor.new(:role => 'stud', :name => 'test')
    end

    it "should have a student role" do
        expect(@personal_info.role).to eq('stud')
    end

    it "should have a name" do
        expect(@personal_info.name).not_to be_empty
    end

  end

  context "when a person is a teaching assistant" do

    before(:all) do
        @personal_info = PersonalInfor.new(:role => 'ta', :name => 'test')
    end

    it "should have a ta role" do
        expect(@personal_info.role).to eq('ta')
    end

    it "should have a name" do
        expect(@personal_info.name).not_to be_empty
    end

  end


  describe "#admin?" do

    it "Yes, someone is administrator!" do

        @personal_info = PersonalInfor.new(:role => 'admin', :name => 'test')
        expect(@personal_info.admin?).to eq true


    end

  end

end
