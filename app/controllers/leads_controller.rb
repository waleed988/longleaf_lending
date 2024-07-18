class LeadsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new(lead_params)
    if @lead.save
      calculate_estimates
      GenerateTermsheetJob.perform_later(@lead.id)
      redirect_to new_lead_path, notice: "Terms sent to your email."
    else
      render :new
    end
  end

  private

  def lead_params
    params.require(:lead).permit(:address, :loan_term, :purchase_price, :repair_budget, :arv, :name, :email, :phone)
  end

  def calculate_estimates
    max_loan_by_purchase = @lead.purchase_price * 0.9
    max_loan_by_arv = @lead.arv * 0.7
    loan_amount = [max_loan_by_purchase, max_loan_by_arv].min + @lead.repair_budget
    monthly_interest_rate = 0.13 / 12
    total_interest = (loan_amount * ((1 + monthly_interest_rate)**@lead.loan_term - 1))
    @lead.estimated_profit = (@lead.arv - loan_amount - total_interest).round(2)
    @lead.loan_amount = loan_amount.round(2)
    @lead.interest_expense = total_interest.round(2)
    @lead.save
  end
end
