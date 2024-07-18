class GenerateTermsheetJob < ApplicationJob
  queue_as :default

  def perform(lead_id)
    lead = Lead.find(lead_id.to_i)
    pdf_path = TermsheetPdf.new(lead).generate
    TermsheetMailer.send_termsheet(lead, pdf_path).deliver_now
  ensure
    File.delete(pdf_path) if File.exist?(pdf_path)
  end

end
