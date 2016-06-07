require "rails_helper"

describe Task do
  it "has a valid factory" do
    FactoryGirl.create(:task).should be_valid
  end
  
  it "is invalid without a name" do
    FactoryGirl.build(:task, name: nil).should_not be_valid
  end

  it "is invalid without a description" do
    FactoryGirl.build(:task, description: nil).should_not be_valid
  end
end
