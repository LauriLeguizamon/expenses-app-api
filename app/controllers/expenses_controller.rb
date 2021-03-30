class ExpensesController < ApplicationController
  ExpensesReducer = Rack::Reducer.new(
    Expense.all,
    ->(user_id:) { where(user_id: user_id) }
  )
  
  def index
    @expenses = ExpensesReducer.apply(params)
    render json: @expenses, status: :ok
  end

  def show 
    @expense = Expense.find(params[:id])
    render json: @expense, status: :ok
  end

  def create
    @expense = Expense.create(create_params)
    render json: @expense, status: :created
  end

  def update 
    @expense = Expense.find(params[:id])
    @expense.update(update_params)
    render json: @expense, status: :ok
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    render json: {"message": "destroyed successfully"}, status: :ok
  end

  private
  def create_params
    params.require(:expense).permit(:name, :description, :ammount, :type, :user_id)
  end

  def update_params 
    params.require(:expense).permit(:name, :description, :ammount, :type, :user_id)
  end
end