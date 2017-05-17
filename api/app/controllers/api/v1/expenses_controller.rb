class Api::V1::ExpensesController < ApplicationController
  before_action :get_expensces, only: [:expenses_by_category]
  def import_data
  	begin 
	  	data_json = JSON.parse(request.body.read) 
	  	create_data(data_json)
  	rescue Exception => e 
  		return render json: "failed"
  	end
  	render json: "Succeed"
  end

  def expenses_by_category
  	return render json:"{}" if params[:category].nil?
  	cal_expense
  end
  private 


  def cal_expense
  	expense_by_category_result = @expenses.select {|hash_element| hash_element[:category] == params[:category]}
  	result = {}
  	result[:total_pre_tax] = expense_by_category_result.sum {|h| h[:pre_tax_amount] }
  	result[:total_with_tax] = result[:total_pre_tax] + expense_by_category_result.sum {|h| h[:tax_amount] }
  	render json: result
  end

  def createExpense(data)
  	expense = Expense.new date: data['date'], category: data['category'], pre_tax_amount: data['pre-tax amount'].gsub(',',''), 
  				expense_description: data['expense description'], tax_name: data['tax name'], tax_amount: data['tax amount'].gsub(',','')
  	employee = Employee.find_by_name data['employee name']
	if expense.employee.nil?
		employee ||= Employee.create name: data['employee name'], address: data['employee address']
	end
	expense.employee = employee
	expense.save!
  end

  def create_data(data_json)
  	data_json.each do |data|
  		createExpense(data)
  	end
  end

  def get_expensces
  	@expenses = Expense.all
  end
end
