class Api::V1::ExpensesController < ApplicationController

  def create
    @flag_result = 'success'
    begin
      raw_list_data = JSON.parse(request.body.read)
      create_data(raw_list_data)
    rescue Exception
      @flag_result = 'error'
    end

    render json: {
      'result': @flag_result
    }
  end

  def total_expenses_by_category
    render json: {
      'expense': (total_expense_by_category('pre_tax_amount') + total_expense_by_category('tax_amount'))
    }
  end

  def total_pre_tax_by_category
    render json: {
      'pre_tax_amount': total_expense_by_category('pre_tax_amount')
    }
  end

  def total_tax_by_category
    render json: {
      'tax_amount': total_expense_by_category('tax_amount')
    }
  end

  private

  def check_params
    if params[:category_name] == nil || params[:year] == nil || params[:month] == nil
      return false
    end

    @category = Category.find_by_name params[:category_name].downcase
    if @category == nil
      return false
    end

    @year_month = params[:year] + '-' + params[:month]
    begin
      Date.parse (@year_month + '-01')
    rescue Exception
      return false
    end

    return true
  end

  def total_expense_by_category(tax_type)
    return 0 if check_params == false
    return Expense.where(['category_id = ? AND date >= ? AND date <= ? ', @category.id, @year_month + '-01', @year_month + '-31']).sum(tax_type)
  end

  def create_data(raw_list_data)
    raw_list_data.each do |data|
      create_employee(data)
      create_category(data)
      create_expense(data)
    end 
  end

  def create_employee(data)
    @employee = Employee.find_by_name data['employee name'].downcase
    @employee ||= Employee.create name: data['employee name'].downcase, address: data['employee address']
  end

  def create_category(data)
    @category = Category.find_by_name data['category'].downcase
    @category ||= Category.create name: data['category'].downcase 
  end

  def create_expense(data)
    @expense = Expense.create employee_id: @employee.id, category_id: @category.id, description: data['expense description'], 
      pre_tax_amount: data['pre-tax amount'].gsub(',', ''), tax_name: data['tax name'], tax_amount: data['tax amount'].gsub(',', ''), 
      date: Time.strptime(data['date'], '%m/%d/%Y')
  end

end
