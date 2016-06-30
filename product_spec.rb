require './product.rb'

describe Product do
  describe "#sales_tax" do
    context "when book product" do
      it "should not have any sales tax" do
        product = Product.new("book", "105.5", "1")
        expect(product.sales_tax).to eq(0)
      end
    end

    context "when medical product" do
      it "should not have any sales tax" do
        product = Product.new("headache tablets", "85.5", "1")
        expect(product.sales_tax).to eq(0)
      end
    end

    context "when food product" do
      it "should not have any sales_tax" do
        product = Product.new("chocolate bar", "85.5", "1")
        expect(product.sales_tax).to eq(0)
      end
    end

    context "when product is other than food, book, medicine" do
      it "should have sales_tax" do
        product = Product.new("music cd", "85.5", "1")
        expect(product.sales_tax).to eq(BigDecimal.new("8.55"))
      end
    end
  end

  describe "#import_duty" do
    context "when product is not imported" do
      it "should not have any import duty" do
        product = Product.new("book", "105.5", "1")
        expect(product.import_duty).to eq(0)
      end
    end

    context "when product is imported" do
      it "should have import duty" do
        product = Product.new("imported wine", "1000.0", "1")
        expect(product.import_duty).to eq(BigDecimal.new("50"))
      end
    end
  end

  describe "#item_total" do
    it "should be sum of price, sales_tax and import duty" do
      product = Product.new("imported music cd", "100.0", "1")
      expect(product.item_total).to eq(BigDecimal.new("115"))
    end
  end
end
