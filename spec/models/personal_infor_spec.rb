require 'rails_helper'

describe PersonalInfor do
  describe "#profile" do

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

  end
end
