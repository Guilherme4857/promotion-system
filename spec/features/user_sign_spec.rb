require 'rails_helper'

feature 'User sign' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    user = User.create! email: 'joao@email.com', password: '123456'
    
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'
    end
    
    expect(page).to have_content 'Login efetuado com sucesso'
    within('nav') do
      expect(page).to have_content user.email
      expect(page).to have_link 'Sair'
      expect(page).to_not have_link 'Entrar'
    end
  end

  scenario 'and logout' do
    user = User.create! email: 'joao@email.com', password: '123456'
    
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'
    end
    click_on 'Sair'
    
    within('nav') do
      expect(page).not_to have_link 'Sair'
      expect(page).not_to have_content user.email
      expect(page).to have_link 'Entrar'
    end    
  end
end