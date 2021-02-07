#require 'rails_helper'

#feature 'Admin edit a promotion' do
#  scenario 'from index page' do
#    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
#    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
#    expiration_date: '22/12/2033')
#
#    visit root_path
#    click_on 'Promoções'
#    click_on 'Natal'
    
#    expect(page).to have_link('Editar', href: edit_promotion_path)
#  end

#  scenario 'successfully' do
#    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
#                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
#                      expiration_date: '22/12/2033')

#    visit root_path
#    click_on 'Promoções'
#    click_on 'Natal'
#    click_on 'Editar'

#    fill_in 'Nome', with: 'Black Friday'
#    fill_in 'Descrição', with: 'Promoção da Black Friday'
#    fill_in 'Código', with: 'BLACK50'
#    fill_in 'Desconto', with: '50'
#    fill_in 'Quantidade de cupons', with: '150'
#    fill_in 'Data de término', with: '20/11/2024'
#    click_on 'Editar promoção'

#    expect(current_path).to eq(Promotion.last)
#    expect(page).to have_content('Black Friday')
#    expect(page).to have_content('Promoção da Black Friday')
#    expect(page).to have_content('50,00%')
#    expect(page).to have_content('BLACK50')
#    expect(page).to have_content('20/11/2024')
#    expect(page).to have_content('150')
#    expect(page).to have_link('Voltar', href: promotions_path)
#  end
  
#end