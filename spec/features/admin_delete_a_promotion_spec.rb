require 'rails_helper'

feature 'Admin delete a promotion' do
  scenario 'must be signed in' do
    visit root_path
    click_on 'Promoções'
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'from index' do
    user = User.create!(email: 'guilherme@gmail.com', password: '123456')
    promotion = Promotion.create(name: 'Natal', description: 'Promoção de Natal', 
                                 code: 'NATAL10', discount_rate: 10, coupon_quantity: 100, 
                                 expiration_date: '20/03/2033', user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on promotion.name

    expect(current_path).to eq promotion_path promotion
    expect(page).to have_link 'Apagar'
  end

  scenario 'successfully' do
    user = User.create!(email: 'guilherme@gmail.com', password: '123456')
    promotion = Promotion.create(name: 'Natal', description: 'Promoção de Natal', 
                                 code: 'NATAL10', discount_rate: 10, coupon_quantity: 100, 
                                 expiration_date: '20/03/2033', user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Apagar'
    
    expect(current_path).to eq promotions_path
    expect(page).not_to have_content promotion.name
    expect(page).not_to have_content promotion.description
    expect(page).not_to have_content promotion.discount_rate
  end
end