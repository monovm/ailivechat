json.id resource.id
# could be nil for a deleted agent hence the safe operator before account id
json.account_id Current.account&.id
json.availability_status resource.availability_status
json.auto_offline resource.auto_offline
json.confirmed resource.confirmed?
json.email resource.email
json.available_name resource.available_name
json.azar_display_name resource.azar_display_name
json.mono_display_name resource.mono_display_name
json.gbits_display_name resource.gbits_display_name
json.custom_attributes resource.custom_attributes if resource.custom_attributes.present?
json.name resource.name
json.role resource.role
json.thumbnail resource.avatar_url
json.azar_avatar_url resource.azar_avatar_url
json.mono_avatar_url resource.mono_avatar_url
json.gbits_avatar_url resource.gbits_avatar_url
json.custom_role_id resource.current_account_user&.custom_role_id if ChatwootApp.enterprise?
