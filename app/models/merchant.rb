class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  def self.top_merchants_by_revenue(number)
    Merchant
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped'})
    .group('merchants.id')
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .order('total_revenue DESC')
    .limit(number)
  end

  def self.top_merchants_by_items_sold(number)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped'})
    .group('merchants.id')
    .select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
    .order('items_sold DESC')
    .limit(number)
  end

  # def how_many_sold(merchant)
  #   merchant.invoices.joins(:invoice_items, :transactions)
  #   .where(transactions: { result: 'success' }, invoices: { status: 'shipped'})
  #   .group('merchants.id')
  #   .select("merchants.*, SUM(invoice_items.quantity) as items_sold")
  #   .count
  # end


end
