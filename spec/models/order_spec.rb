require 'rails_helper'

RSpec.describe Order, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject { Order.new( product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))}
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    it "is not valid without a product_name" do
      subject.product_name=nil
      expect(subject).to_not be_valid
    end
    it "is not valid without a product_count" do
      subject.product_count=nil
      expect(subject).to_not be_valid
    end
    it "is not valid if without a customer name" do
      subject.customer.first_name=nil 
      subject.customer.last_name=nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid if no customer is selected" do
      subject.customer=nil
      expect(subject).to_not be_valid
    end

    # expect(customer.last_name).to_not be_empty
end
