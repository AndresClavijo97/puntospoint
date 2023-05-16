require "rails_helper"

RSpec.describe Admin::ReportsMailer, type: :mailer do
  describe "send_daily_purchases" do
    let(:mail) { Admin::ReportsMailer.send_daily_purchases }

    it "renders the headers" do
      expect(mail.subject).to eq("Send daily purchases")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
