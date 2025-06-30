# AzarOnline Persian Locale Configuration

## Overview

This document explains the implementation of automatic Persian ('fa') locale setting for the AzarOnline inbox in Chatwoot.

## Problem Statement

The user had 3 inboxes in one Chatwoot account, where:
- The account-level locale was configurable but applied to all inboxes
- The third inbox "AzarOnline" specifically needed to use Persian ('fa') locale
- Other inboxes should continue using the account-level locale

## Solution

We implemented a conditional locale setting that automatically detects when the inbox name is "AzarOnline" (case-insensitive) and sets the locale to Persian ('fa'), while preserving the account-level locale for all other inboxes.

## Implementation Details

### 1. Widget View Configuration

**File**: `app/views/widgets/show.html.erb`

**Change**: Modified the locale setting from:
```erb
locale: '<%= @web_widget.account.locale %>',
```

To:
```erb
locale: '<%= @web_widget.inbox.name.downcase == "azaronline" ? "fa" : @web_widget.account.locale %>',
```

### 2. API Configuration

**File**: `app/views/api/v1/widget/configs/create.json.jbuilder`

**Change**: Modified the locale setting from:
```ruby
json.locale @web_widget.account.locale
```

To:
```ruby
json.locale @web_widget.inbox.name.downcase == 'azaronline' ? 'fa' : @web_widget.account.locale
```

### 3. Logic Explanation

The conditional logic works as follows:

1. **Check inbox name**: Converts the inbox name to lowercase for case-insensitive comparison
2. **AzarOnline detection**: If the lowercase inbox name equals "azaronline", set locale to 'fa'
3. **Fallback**: For all other inbox names, use the account's configured locale

This approach ensures:
- ✅ AzarOnline inbox always uses Persian ('fa') locale regardless of account settings
- ✅ Other inboxes continue using the account-level locale
- ✅ Case-insensitive matching (AzarOnline, AZARONLINE, azaronline all work)
- ✅ Backward compatibility maintained for existing functionality

## Persian Locale Support

Chatwoot already has comprehensive Persian locale support:
- Translation files: `config/locales/fa.yml`, `app/javascript/dashboard/i18n/locale/fa/`
- Widget components already check for 'azaronline' in multiple places
- All UI components, messages, and interface elements are fully translated

## Testing

Comprehensive test coverage has been implemented:

### Widget View Tests
**File**: `spec/views/widgets/show_spec.rb`

Tests verify:
- AzarOnline inbox gets 'fa' locale
- Case-insensitive matching (azaronline, AZARONLINE)
- Other inboxes use account locale
- Account locale override behavior

### API Configuration Tests
**File**: `spec/views/api/v1/widget/configs/create_spec.rb`

Tests verify:
- API responses contain correct locale
- Consistent behavior with widget view
- JSON response structure integrity

## Usage Examples

### Example 1: AzarOnline Inbox
- **Inbox Name**: "AzarOnline"
- **Account Locale**: "en"
- **Result**: Widget uses Persian ('fa') locale

### Example 2: Other Inbox
- **Inbox Name**: "Customer Support"
- **Account Locale**: "en"
- **Result**: Widget uses English ('en') locale

### Example 3: Case Variations
All these inbox names will trigger Persian locale:
- "AzarOnline"
- "azaronline"
- "AZARONLINE"
- "aZaRoNlInE"

## Benefits

1. **Automatic**: No manual configuration required
2. **Targeted**: Only affects AzarOnline inbox
3. **Maintainable**: Centralized logic in two key files
4. **Flexible**: Easy to extend for other special cases
5. **Tested**: Comprehensive test coverage ensures reliability
6. **Performance**: Minimal overhead with simple string comparison

## Future Enhancements

If needed, this approach can be extended to:
1. Support multiple special inbox names with different locales
2. Use a configuration file for special locale mappings
3. Add database-level inbox-specific locale settings

## Files Modified

1. `app/views/widgets/show.html.erb` - Widget configuration
2. `app/views/api/v1/widget/configs/create.json.jbuilder` - API configuration
3. `spec/views/widgets/show_spec.rb` - Widget view tests
4. `spec/views/api/v1/widget/configs/create_spec.rb` - API tests
5. `docs/AzarOnline_Locale_Configuration.md` - This documentation

## Deployment Notes

- No database migrations required
- No server restart required
- Changes take effect immediately
- Existing widget instances will pick up new locale on next page load 