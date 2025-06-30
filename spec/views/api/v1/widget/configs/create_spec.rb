require 'rails_helper'

RSpec.describe 'api/v1/widget/configs/create.json.jbuilder', type: :view do
  let(:account) { create(:account, locale: 'en') }
  let(:web_widget) { create(:channel_widget, account: account) }
  let(:inbox) { web_widget.inbox }
  let(:contact) { create(:contact, account: account) }
  let(:contact_inbox) { create(:contact_inbox, contact: contact, inbox: inbox) }
  let(:token) { 'test_token' }
  let(:global_config) { { 'INSTALLATION_NAME' => 'Test Installation' } }

  before do
    # Update the inbox name for the test
    inbox.update!(name: inbox_name)
    
    assign(:web_widget, web_widget)
    assign(:contact, contact)
    assign(:contact_inbox, contact_inbox)
    assign(:token, token)
    assign(:global_config, global_config)
    allow(view).to receive(:available_locales_with_name).and_return([])
  end

  context 'when inbox name is AzarOnline' do
    let(:inbox_name) { 'AzarOnline' }

    it 'sets locale to fa (Persian) in API response' do
      render
      config = JSON.parse(rendered)
      expect(config['website_channel_config']['locale']).to eq('fa')
      expect(config['website_channel_config']['website_name']).to eq('AzarOnline')
    end
  end

  context 'when inbox name is azaronline (lowercase)' do
    let(:inbox_name) { 'azaronline' }

    it 'sets locale to fa (Persian) regardless of case' do
      render
      config = JSON.parse(rendered)
      expect(config['website_channel_config']['locale']).to eq('fa')
      expect(config['website_channel_config']['website_name']).to eq('azaronline')
    end
  end

  context 'when inbox name is AZARONLINE (uppercase)' do
    let(:inbox_name) { 'AZARONLINE' }

    it 'sets locale to fa (Persian) regardless of case' do
      render
      config = JSON.parse(rendered)
      expect(config['website_channel_config']['locale']).to eq('fa')
      expect(config['website_channel_config']['website_name']).to eq('AZARONLINE')
    end
  end

  context 'when inbox name is not AzarOnline' do
    let(:inbox_name) { 'Regular Inbox' }

    it 'uses account locale' do
      render
      config = JSON.parse(rendered)
      expect(config['website_channel_config']['locale']).to eq('en')
      expect(config['website_channel_config']['website_name']).to eq('Regular Inbox')
    end
  end

  context 'when account has different locale and inbox is AzarOnline' do
    let(:account) { create(:account, locale: 'es') }
    let(:inbox_name) { 'AzarOnline' }

    it 'overrides account locale with fa for AzarOnline' do
      render
      config = JSON.parse(rendered)
      expect(config['website_channel_config']['locale']).to eq('fa')
      expect(config['website_channel_config']['locale']).not_to eq('es')
    end
  end

  context 'when account has different locale and inbox is not AzarOnline' do
    let(:account) { create(:account, locale: 'fr') }
    let(:inbox_name) { 'Other Inbox' }

    it 'uses account locale' do
      render
      config = JSON.parse(rendered)
      expect(config['website_channel_config']['locale']).to eq('fr')
      expect(config['website_channel_config']['website_name']).to eq('Other Inbox')
    end
  end
end 