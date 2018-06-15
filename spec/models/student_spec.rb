require 'rails_helper'

RSpec.describe Student do

  context "when there is a student record in database" do

    before(:all) do
      @stu = Student.new(:student_id => '103703042', :name => 'alex', :email => 'alex@google.com')
    end

    it "should have a student id" do
      expect(@stu.student_id).not_to be_empty
    end

    it "should have a name" do
      expect(@stu.name).not_to be_empty
    end

    it "should have a email address" do
      expect(@stu.email).not_to be_empty
    end

  end

end
