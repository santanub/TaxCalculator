#!/usr/bin/env ruby

require 'csv'
require_relative 'product'

file_name = ARGV[0]

unless File.exist?(file_name)
  puts "File does not exist"
  exit
end

output_file = ARGV[1] || "output.csv"

csv_rows = CSV.read(file_name, headers: true, encoding: 'utf-8')
products = []

csv_rows.each do |row|
  next if row["Product"].empty?
  products << Product.new(row["Product"], row["Price"], row["Quantity"])
end

CSV.open(output_file, "wb") do |csv|
  total = total_sales_tax = total_import_duty = BigDecimal.new("0")

  products.each do |product|
    csv << [product.quantity, product.name, product.item_total.to_s("F")]
    total_sales_tax += product.sales_tax
    total_import_duty += product.import_duty
    total += product.item_total
  end

  csv << []
  csv << ["Sales Tax", "", (total_sales_tax + total_import_duty).to_s("F")]
  csv << ["Total", "", total.to_s("F")]
end
