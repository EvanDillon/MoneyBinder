class PdfMailer < ApplicationMailer
  def trial_balance_email
    pdf_name = params[:pdf_name]
    email = params[:user_email]
    @sender = params[:sender_user]
    @non_zero_accounts = params[:non_zero_accounts]

    attachments["#{pdf_name}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: "#{pdf_name}_#{Time.now.year}", template: "sessions/reports_pdf/#{pdf_name}.html.erb")
    )
    mail(to: email, subject: "Moneybinder Trial Balance Report")
  end

  def income_statement_email
    pdf_name = params[:pdf_name]
    email = params[:user_email]
    @sender = params[:sender_user]
    @revenue_accounts = params[:revenue_accounts]
    @total_revenues = params[:total_revenues]
    @expense_accounts = params[:expense_accounts]
    @total_expenses = params[:total_expenses]

    attachments["#{pdf_name}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: "#{pdf_name}_#{Time.now.year}", template: "sessions/reports_pdf/#{pdf_name}.html.erb")
    )
    mail(to: email, subject: "Moneybinder Income Statement Report")
  end

  def retained_earnings_email
    pdf_name = params[:pdf_name]
    email = params[:user_email]
    @sender = params[:sender_user]
    @beginning_balance = params[:beginning_balance]
    @net_income = params[:net_income]
    @less_drawings = params[:less_drawings]

    attachments["#{pdf_name}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: "#{pdf_name}_#{Time.now.year}", template: "sessions/reports_pdf/#{pdf_name}.html.erb")
    )
    mail(to: email, subject: "Moneybinder Retained Earnings Report")
  end

  def balance_sheet_email
    pdf_name = params[:pdf_name]
    email = params[:user_email]
    @sender = params[:sender_user]
    @current_assets = params[:current_assets]
    @equipment_assets = params[:equipment_assets]
    @liability_accounts = params[:liability_accounts]
    @equity_accounts = params[:equity_accounts]
    @retained_earnings_account = params[:retained_earnings_account]
    @total_equity = params[:total_equity]

    attachments["#{pdf_name}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: "#{pdf_name}_#{Time.now.year}", template: "sessions/reports_pdf/#{pdf_name}.html.erb")
    )
    mail(to: email, subject: "Moneybinder Balance Sheet Report")
  end
end
