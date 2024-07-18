class CreateLeads < ActiveRecord::Migration[6.0]
  def change
    create_table :leads do |t|
      t.string :address
      t.integer :loan_term
      t.decimal :purchase_price
      t.decimal :repair_budget
      t.decimal :arv
      t.string :name
      t.string :email
      t.string :phone
      t.decimal :estimated_profit
      t.decimal :loan_amount
      t.decimal :interest_expense

      t.timestamps
    end
  end
end
