require 'rails_helper'

feature 'Admin edit a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'from index page' do
    user = User.create!(email: 'guilherme@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    
    expect(current_path).to eq promotion_path(promotion)
    expect(page).to have_link('Editar', href: edit_promotion_path(promotion))
  end

  scenario 'successfully' do
    user = User.create!(email: 'guilherme@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Editar'

    fill_in 'Nome', with: 'Black Friday'
    fill_in 'Descrição', with: 'Promoção da Black Friday'
    fill_in 'Código', with: 'BLACK50'
    fill_in 'Desconto', with: '50'
    fill_in 'Quantidade de cupons', with: '150'
    fill_in 'Data de término', with: '20/11/2024'
    click_on 'Atualizar Promoção'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Black Friday')
    expect(page).to have_content('Promoção da Black Friday')
    expect(page).to have_content('50,00%')
    expect(page).to have_content('BLACK50')
    expect(page).to have_content('20/11/2024')
    expect(page).to have_content('150')
    expect(page).to have_link('Voltar', href: promotions_path)
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(email: 'guilherme@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
  
    login_as user, scope: :user
  
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Criar Promoção'
    expect(page).to have_content('Não foi possível criar a promoção')
    expect(page).to have_content("Nome não pode ficar em branco")
    expect(page).to have_content("Código não pode ficar em branco")
    expect(page).to have_content("Desconto não pode ficar em branco")
    expect(page).to have_content("Quantidade de cupons não pode ficar em branco")
    expect(page).to have_content("Data de término não pode ficar em branco")
  end
  
  scenario 'and code must be unique' do
    user = User.create!(email: 'guilherme@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    user = User.create! email: 'joao@email.com', password: '123456'
    login_as user, scope: :user
  
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar Promoção'
  
    expect(page).to have_content('já está em uso')
  end

  scenario 'code must content letters' do
    user = User.create!(email: 'guilherme@email.com', password: '123456')
    login_as user, scope: :user
    
    visit new_promotion_path
    
    fill_in 'Nome', with: 'Natal'
    fill_in 'Descrição', with: 'Promoção de Natal'
    fill_in 'Código', with: '10'
    fill_in 'Desconto', with: '10'
    fill_in 'Quantidade de cupons', with: 100
    fill_in 'Data de término', with: '22/12/2023'
    click_on 'Criar Promoção'

    expect(page).to have_content('Código precisa conter letras')
  end

  scenario 'code must be uppercase' do
    user = User.create!(email: 'guilherme@email.com', password: '123456')
    login_as user, scope: :user
    
    visit new_promotion_path

    fill_in 'Nome', with: 'Natal'
    fill_in 'Descrição', with: 'Promoção de Natal'
    fill_in 'Código', with: 'Natal10'
    fill_in 'Desconto', with: '10'
    fill_in 'Quantidade de cupons', with: 100
    fill_in 'Data de término', with: '22/12/2023'
    click_on 'Criar Promoção'

    expect(page).to have_content('Código precisa ter todas as letras maiúsculas')
  end
end