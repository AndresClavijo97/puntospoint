require "rails_helper"

RSpec.describe Admin::NotificationMailer, type: :mailer do
  describe "first_purchase" do
    let(:mail) { Admin::NotificationMailer.first_purchase }

    it "renders the headers" do
      expect(mail.subject).to eq("First purchase")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
