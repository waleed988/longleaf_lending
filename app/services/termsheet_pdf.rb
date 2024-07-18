class TermsheetPdf
  include Prawn::View

  def initialize(lead)
    @lead = lead
  end

  def generate
    Prawn::Document.generate(pdf_path) do |pdf|
      pdf.font 'Helvetica'
  
      pdf.text "Termsheet for #{@lead.name}", size: 24, style: :bold, align: :center
      pdf.move_down 20
  
      pdf.text 'Property Details', size: 18, style: :bold, color: '3366cc'
      pdf.move_down 10
      pdf.indent(20) do
        pdf.text "Address: #{@lead.address}"
        pdf.text "Loan Term: #{@lead.loan_term} months"
        pdf.text "Purchase Price: $#{number_to_currency(@lead.purchase_price)}"
        pdf.text "Repair Budget: $#{number_to_currency(@lead.repair_budget)}"
        pdf.text "After Repair Value (ARV): $#{number_to_currency(@lead.arv)}"
      end
      pdf.move_down 20
  
      pdf.text 'Financial Summary', size: 18, style: :bold, color: '3366cc'
      pdf.move_down 10
      pdf.indent(20) do
        pdf.text "Estimated Profit: $#{number_to_currency(@lead.estimated_profit)}"
        pdf.text "Loan Amount: $#{number_to_currency(@lead.loan_amount)}"
        pdf.text "Interest Expense: $#{number_to_currency(@lead.interest_expense)}"
      end
      pdf.move_down 20
  
      pdf.text 'Thank you for choosing Longleaf Lending!', align: :center, size: 14, color: '666666'
      pdf.move_down 10
  
      pdf.number_pages '<page> of <total>',
        at: [pdf.bounds.right - 150, 0],
        width: 150,
        align: :right,
        size: 10,
        color: '666666',
        start_count_at: 1
    end
    pdf_path
  end

  def number_to_currency(number)
    ActionController::Base.helpers.number_to_currency(number, unit: '$', precision: 2)
  end

  def pdf_path
    Rails.root.join('tmp', "termsheet_#{@lead.id}.pdf")
  end

end
