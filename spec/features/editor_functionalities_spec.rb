require 'rails_helper'
include Warden::Test::Helpers

describe "editor functionalities" do
  before(:each) do
    @editor = Factory.create(:user)
    login_as @editor, scope: :user
  end
  context 'proper redirection to checkpoint options' do
    let!(:editor) { create(:user, :editor) }
    visit '/'
    before(:each) do
      expect(page).to have_content("Checkpoint")
    end

    it "choose 'Control' option" do
      check("checkpoint_control")
      expect(page).to have_content("editor")
      click_button 'Escojer un lugar'
    end
    it "choose 'Terminal' option" do
      check("checkpoint_terminal")
      expect(page).to have_content("editor")
      click_button 'Escojer un lugar'
    end
  end
  
  context 'all records have "Terminal" checkpoint' do

  end
  context 'in "Control" checkpoint' do

  end
end