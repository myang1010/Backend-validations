require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject { Customer.new(first_name: "Jack", last_name: "Smith", phone: "8889995678", email: "jsmith@sample.com" )}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a first_name" do
    subject.first_name=nil
    # subject2 = subject.first_name=""

    expect(subject).to_not be_valid
    # expect(subject2).to_not be_valid
  end
  it "is not valid without a last_name" do
    subject.last_name=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a phone number" do
    subject.phone=nil
    expect(subject).to_not be_valid
  end
  it "is not valid without an email" do
    subject.email=nil
    expect(subject).to_not be_valid
  end
  context "with phone number is not valid" do
    it "is not valid if the phone number is less than 10 chars" do
      subject.phone='123456789'
      expect(subject).to_not be_valid
    end
    it "is not valid if the phone number is more than 10 chars" do
      subject.phone="12345678901"
      expect(subject).to_not be_valid
    end
    it "is not valid if the phone number is not all digits" do
      subject.phone="1234text00"
      expect(subject).to_not be_valid
    end
  end
  it "is not valid if the email address doesn't have a @" do
    subject.email="jsmithsample.com"
    expect(subject).to_not be_valid
  end
  it "returns the correct full_name" do
    expect(subject.full_name).to eq("Jack Smith")
  end
end
