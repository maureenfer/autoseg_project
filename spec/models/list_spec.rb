require "rails_helper"

describe List do
  it "has a valid factory" do
    FactoryGirl.create(:list).should be_valid
  end
  
  it "is invalid without a name" do
    FactoryGirl.build(:list, name: nil).should_not be_valid
  end
end
