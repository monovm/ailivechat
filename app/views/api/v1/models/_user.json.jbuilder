json.access_token resource.access_token.token
json.account_id resource.active_account_user&.account_id
json.available_name resource.available_name
json.avatar_url resource.avatar_url
json.azar_avatar_url resource.azar_avatar_url
json.mono_avatar_url resource.mono_avatar_url
json.gbits_avatar_url resource.gbits_avatar_url
json.confirmed resource.confirmed?
json.display_name resource.display_name
json.azar_display_name resource.try(:azar_display_name)
json.mono_display_name resource.try(:mono_display_name)
json.gbits_display_name resource.try(:gbits_display_name)
json.message_signature resource.message_signature
json.azar_message_signature resource.azar_message_signature
json.mono_message_signature resource.mono_message_signature
json.gbits_message_signature resource.gbits_message_signature
json.email resource.email
json.hmac_identifier resource.hmac_identifier if GlobalConfig.get('CHATWOOT_INBOX_HMAC_KEY')['CHATWOOT_INBOX_HMAC_KEY'].present?
json.id resource.id
json.inviter_id resource.active_account_user&.inviter_id
json.name resource.name
json.provider resource.provider
json.pubsub_token resource.pubsub_token
json.custom_attributes resource.custom_attributes if resource.custom_attributes.present?
json.role resource.active_account_user&.role
json.ui_settings resource.ui_settings
json.uid resource.uid
json.type resource.type
json.accounts do
  json.array! resource.account_users do |account_user|
    json.id account_user.account_id
    json.name account_user.account.name
    json.status account_user.account.status
    json.active_at account_user.active_at
    json.role account_user.role
    json.permissions account_user.permissions
    # the actual availability user has configured
    json.availability account_user.availability
    # availability derived from presence
    json.availability_status account_user.availability_status
    json.auto_offline account_user.auto_offline
    json.partial! 'api/v1/models/account_user', account_user: account_user if ChatwootApp.enterprise?
  end
end
