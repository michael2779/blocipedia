require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(email: "user@example.com", password: "password") }
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", user: user) }

# #2
  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "New Wiki Title", body: "New Wiki Body")
    end
  end
end
