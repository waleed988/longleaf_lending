class TermsheetMailer < ApplicationMailer
  default from: 'no-reply@longleaflending.com'

  def send_termsheet(lead, pdf_path)
    @lead = lead
    attachments['termsheet.pdf'] = File.read(pdf_path)
    mail(to: @lead.email, subject: 'Your Termsheet from Longleaf Lending')
  end
end
