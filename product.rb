require 'bigdecimal'

class Product
  attr_reader :name, :price, :quantity

  def initialize(name, price, quantity)
    @name = name
    @price = BigDecimal.new(price)
    @quantity = quantity.to_i
  end

  def sales_tax
    round_upto_five_cents(calculated_price * sales_tax_rate)
  end

  def import_duty
    round_upto_five_cents(calculated_price * import_duty_rate)
  end

  def item_total
    calculated_price + sales_tax + import_duty
  end

  private

  def calculated_price
    price * quantity
  end

  def import_duty_rate
    name =~ /import(.*)/i ? 0.05 : 0
  end

  def sales_tax_rate
    if name =~ /book|food|chocolate|pill|headache|medicine/i
      0
    else
      0.1
    end
  end

  def round_upto_five_cents(price)
    (price * 2).round(1) / 2.0
  end
end
