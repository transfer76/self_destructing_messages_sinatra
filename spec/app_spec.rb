require_relative 'spec_helper'

describe 'App' do

  it 'should create new message' do
    visit '/new'
    fill_in 'text', with: 'My message'
    select 'link visits', from: 'destruction_option'
    fill_in 'destruction_option_value', with: '1'
    click_button 'Create message'
    expect(page).to have_content 'My message'
  end

  context 'when message is destroyed after link visits' do
    it 'should destroy message after one visit' do
      visit '/new'
      fill_in 'text', with: 'My message'
      select 'link visits', from: 'destruction_option'
      fill_in 'destruction_option_value', with: '1'
      click_button 'Create message'
      visit current_path
      expect(page).to have_content 'My message'
      visit current_path
      expect(page).not_to have_content 'My message'
    end

    it 'should destroy message after visits' do
      n = 10
      visit '/new'
      fill_in 'text', with: 'My message'
      select 'link visits', from: 'destruction_option'
      fill_in 'destruction_option_value', with: n
      click_button 'Create message'
      n.times { visit current_path }
      expect(page).to have_content 'My message'
      visit current_path
      expect(page).not_to have_content 'My message'
    end
  end

  context 'when message is destroyed after some time' do
    it 'should destroy message after one hour' do
      visit '/new'
      fill_in 'text', with: 'My message'
      select 'hours', from: 'destruction_option'
      fill_in 'destruction_option_value', with: '1'
      click_button 'Create message'
      Timecop.freeze(DateTime.now + 59.minutes + 59.seconds) do
        visit current_path
        expect(page).to have_content 'My message'
      end
      Timecop.freeze(DateTime.now + 1.hour) do
        visit current_path
        expect(page).to have_content 'My message'
      end
    end

    it 'should destroy message after some hours' do
      n = 50
      visit '/new'
      fill_in 'text', with: 'My message'
      select 'hours', from: 'destruction_option'
      fill_in 'destruction_option_value', with: n
      click_button 'Create message'
      Timecop.freeze(DateTime.now + (n - 1).hours + 59.minutes + 59.seconds) do
        visit current_path
        expect(page).to have_content 'My message'
      end
      Timecop.freeze(DateTime.now + n.hour) do
        visit current_path
        expect(page).to have_content 'My message'
      end
    end
  end
end
