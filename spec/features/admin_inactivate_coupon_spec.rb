require 'rails_helper'

feature 'Admin inactivate coupon' do 
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'
    
    expect(current_path).to eq new_user_session_path
  end
  scenario 'successfully' do
    user = User.create!(email: 'guilherme@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    coupon = Coupon.create!(code: 'NATAL10-0057', promotion: promotion)
    user = User.create! email: 'joao@email.com', password: '123456'
    login_as user, scope: :user
    
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Desativar cupom'
    
    coupon.reload
    expect(page).to have_content("Cupom NATAL10-0057 desativado")
    expect(coupon).to be_inactive
  end

  scenario 'does not view button' do
    user = User.create!(email: 'guilherme@email.com', password: '123456')
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    inactive_coupon = Coupon.create!(code: 'NATAL10-0057', promotion: promotion, status: :inactive)
    active_coupon = Coupon.create!(code: 'NATAL10-0058', promotion: promotion, status: :active)
    user = User.create! email: 'joao@email.com', password: '123456'
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    
    expect(page).to have_content("Cupom NATAL10-0057 desativado")
    expect(page).to have_content("Cupom NATAL10-0058 ativo")

    within("div#coupon-#{active_coupon.id}") do
      expect(page).to have_link('Desativar cupom')
    end
    
    within("div#coupon-#{inactive_coupon.id}") do
      expect(page).not_to have_link('Desativar cupom')
    end
  end
end