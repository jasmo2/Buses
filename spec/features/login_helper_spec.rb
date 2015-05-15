require 'rails_helper'

describe "Login User" do
  context "not register User" do
    it "pass invalid credentials" do
      visit '/'
      within("#new_user") do
        fill_in "user_username", with: "not_a_user"
        fill_in "user_password", with: "santiago"
      end
      click_button 'Ingresar'
      expect(page).to have_content ("Usuario o contraseña inválidos")
    end
  end
  context "with admin role" do
    let!(:admin) { create(:user, :admin) }
    it "redirect to users#dashboard" do
      visit '/'
      within("#new_user") do
        fill_in "user_username", with: admin.username
        fill_in "user_password", with: admin.password
      end
      click_button 'Ingresar'
      expect(page).to have_content ("Administración Coonatra")
    end
  end
  context "with editor role" do
    let!(:editor) { create(:user, :editor) }
    it "render to Checkpoint view" do
      visit '/'
      within("#new_user") do
        fill_in "user_username", with: editor.username
        fill_in "user_password", with: editor.password
      end
      click_button 'Ingresar'
      expect(page).to have_content ("Checkpoint")
    end
  end
  context "with reader role" do
    let!(:reader) { create(:user, :reader) }
    it "bus_routes#new" do
      visit '/'
      within("#new_user") do
        fill_in "user_username", with: reader.username
        fill_in "user_password", with: reader.password
      end
      click_button 'Ingresar'
      expect(page).to have_content ("Lector")
    end
  end
end