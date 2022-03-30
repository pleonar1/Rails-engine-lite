require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
   it { should belong_to(:invoice) }
   it { should belong_to(:item) }
   it { should have_many(:bulk_discounts).through(:item) }
  end
end
