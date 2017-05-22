require "rails_helper"

RSpec.describe Api::V1::ExpensesController do
  context 'when post json data' do
    let(:file_path) { Rails.root.join('expenses.json') }
    let(:json) { JSON.parse(File.read(file_path)) }
    subject do
      post :import, format: :json, :_json => json
    end

    it 'has corresponding records in databases' do
      subject
      expect(Expense.last.category.name).to eq(json.last["category"])
      expect(Expense.count).to eq(json.size)
    end
  end  
end