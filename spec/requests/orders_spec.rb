require 'rails_helper'

# If a redirect is expected to occur, one should check that the redirect goes to the right page,
# expect (response).to redirect_to orders_path
# If a redirect does not occur, you should check that the right page template is displayed:
# expect (response).to render_template(:show)

RSpec.describe "Orders", type: :request do
  describe "get orders_path" do
    it "renders the index view" do
      FactoryBot.create_list(:order, 10)
      get orders_path, params:{}
      expect(response).to render_template(:index)
    end
  end
  describe "get order_path" do
    it "renders the :show template" do
      order = FactoryBot.create(:order) 
      get order_path(id: order.id), params:{}
      expect(response).to render_template(:show)
    end
    it "redirects to the index path if the order id is invalid" do
      get order_path(id: 5000), params:{} #an ID that doesn't exist
      expect(response).to redirect_to orders_path
    end
  end
  describe "get new_order_path" do
    it "renders the :new template" do
      order = FactoryBot.create(:order)
      get new_order_path(id: order.id), params:{}
      expect(response).to render_template(:new)
    end
  end
  describe "get edit_order_path" do
    it "renders the :edit template" do
      order = FactoryBot.create(:order)
      get edit_order_path(id: order.id), params:{}
      expect(response).to render_template(:edit)
    end
  end
  # For the post method, we need to get the attributes for an order object. 
  # If we do attributes = FactoryBot.attributes_for(:order) it will not store anything in the database. 
  # It will also not create any attributes corresponding to the customer. 
  # So we have to create the customer object explicitly, and add its id to the list of attributes
  describe "post orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
        #Returns a hash of attributes that can be used to build a Order instance
      expect { post orders_path, params: {order: order_attributes}
    }.to change(Order, :count).by(1)
      expect(response).to redirect_to order_path(id: Order.last.id)
    end
  end
  context "post orders_path with invalid data" do
    it "does not save a new entry or redirect without a product_name" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      order_attributes.delete(:product_name)
      expect { post orders_path, params: {order: order_attributes}
    }.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
    it "does not save a new entry or redirect without a product_count" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      order_attributes.delete(:product_count)
      expect { post orders_path, params: {order: order_attributes}
    }.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
    it "does not save a new entry or redirect without a valid customer_id" do
      customer = FactoryBot.create(:customer)
      customer.id = "3333"
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      expect { post orders_path, params: {order: order_attributes}
    }.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
  end
  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the order" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {product_count: 50}}
      order.reload
      expect(order.product_count).to eq(50)
      expect(response).to redirect_to("/orders/#{order.id}")
    end
  end
  describe "put order_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {customer_id: 5001}}
      order.reload
      expect(order.customer_id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end
  describe "delete an order record" do
    it "deletes a order record" do
      order = FactoryBot.create(:order)
      delete order_path(order.id), params:{}
      expect(response).to redirect_to orders_path 
    end
  end
end
