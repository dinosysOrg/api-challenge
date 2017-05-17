class Api::V1::ExpensesController < ApplicationController
  def import_data
  	data_json = JSON.parse(request.body.read)
  	@expenses = []
  	data_json.each do |data|
  		
  		expense = Expense.new date: data['date'], category: data['category'], pre_tax_amount: data['pre-tax amount'].gsub(',',''), 
  				expense_description: data['expense description'], tax_name: data['tax name'], tax_amount: data['tax amount'].gsub(',','')

  		employee = Employee.find_by_name data['employee name']
  		if expense.employee.nil?
  			employee ||= Employee.create name: data['employee name'], address: data['employee address']
  		end
  		expense.employee = employee

  		@expenses << expense
  	end

  	if @expenses.each(&:save!)
  		render json:"Succeed"
  	else
  		render json:"Failed"
  	end
  end
end
