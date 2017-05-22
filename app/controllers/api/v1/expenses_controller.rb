class Api::V1::ExpensesController < ApplicationController

  def  import
    return if params["_json"].nil?
    params["_json"].each do |json|
      expense = Expense.new
      # if category not found, create one
      category = Category.find_by(name: json["category"]) || Category.create!(name: json["category"])

      expense["date"] = json["date"]
      expense["category_id"] = category.id
      expense["employee_name"] = json["employee name"]
      expense["employee_address"] = json["employee address"]
      expense["expense_description"] = json["expense description"]
      expense["pre_tax_amount"] = json["pre-tax amount"]
      expense["tax_name"] = json["tax name"]
      expense["tax_amount"] = json["tax amount"]
      expense.save
    end
    render text: 'import complete'
  end

  # GET /expenses/total_expense_by_category
  def total_expense_by_category
    @expense_categories = []
    categories = Category.all
    categories.each do |category|
      expense_record = {"name" => category.name, "total_expense" => Expense.where(category_id: category.id).sum(:pre_tax_amount)}
      @expense_categories.push(expense_record)
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:date, :category_id, :employee_name, :employee_address, :expense_description, :pre_tax_amount, :tax_name, :tax_amount)
    end
end
