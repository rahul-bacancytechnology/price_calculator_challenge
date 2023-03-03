require_relative '../../price_calculator_challenge/solution.rb'
require 'pry'

RSpec.describe LocalStore do

  before do
    @store = LocalStore.new
  end

  describe "#checkout" do
    context "given an empty string" do
      it "should returns zero for total price" do
        store = @store
        store.items = ""
        store.checkout
        expect(store.instance_variable_get(:@final_sale_price)).to eq(0)
      end
    end

    context "give items" do
      it "should returns total price" do
        store = @store
        store.instance_variable_set(:@items,"milk,apple")
        store.cost_of_items
        store.checkout
        expect(store.instance_variable_get(:@final_sale_price)).not_to eq(0)
      end
    end

    context "give wrong items" do
      it "should returns zero for total price" do
        store = @store
        store.instance_variable_set(:@items,"milk1,apple2")
        store.cost_of_items
        store.checkout
        expect(store.instance_variable_get(:@final_sale_price)).to eq(0)
      end
    end
  end
end