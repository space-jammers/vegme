require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'foundation_class_for(flash_type)' do
    it 'returns flash-success class for a success flash' do
      expect(foundation_class_for('success')).to eq('flash-success')
    end

    it 'returns flash-error class for a error flash' do
      expect(foundation_class_for('error')).to eq('flash-error')
    end

    it 'returns flash-error class for a alert flash' do
      expect(foundation_class_for('alert')).to eq('flash-error')
    end

    it 'returns flash-notice class for a notice flash' do
      expect(foundation_class_for('notice')).to eq('flash-notice')
    end

    it 'returns flash-notice as the default class' do
      expect(foundation_class_for('HOOPLA')).to eq('flash-notice')
    end
  end

  describe 'flash_icon_for(flash_type)' do
    it 'returns fa-check-circle class for a success flash' do
      expect(flash_icon_for('success')).to eq('fa-check-circle')
    end

    it 'returns fa-exclamation-circle class for a error flash' do
      expect(flash_icon_for('error')).to eq('fa-exclamation-circle')
    end

    it 'returns fa-exclamation-circle class for a alert flash' do
      expect(flash_icon_for('alert')).to eq('fa-exclamation-circle')
    end

    it 'returns fa-info-circle class for a notice flash' do
      expect(flash_icon_for('notice')).to eq('fa-info-circle')
    end

    it 'returns fa-info-circle as the default class' do
      expect(flash_icon_for('HOOPLA')).to eq('fa-info-circle')
    end
  end

  describe 'get_user_email' do
    let(:user) { User.create!(email: 'testing@here.com', password: 'sdkjh59sda') }

    it 'returns the email address for an active user' do
      expect(get_user_email(user.id)).to eq('testing@here.com')
    end

    it 'returns "User No Longer Active" for an use whose account does not exist' do
      user.destroy
      expect(get_user_email(user.id)).to eq('User No Longer Active')
    end
  end
end
