# Google Sheets Integration Setup Guide

This guide will help you set up Google Sheets integration for order management in your Leather E-commerce app.

## Prerequisites

1. A Google account
2. Access to Google Cloud Console
3. A Google Sheets spreadsheet

## Step 1: Create a Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the Google Sheets API:
   - Go to "APIs & Services" > "Library"
   - Search for "Google Sheets API"
   - Click on it and press "Enable"

## Step 2: Create Credentials

1. Go to "APIs & Services" > "Credentials"
2. Click "Create Credentials" > "API Key"
3. Copy the API key (you'll need this later)
4. (Optional) Restrict the API key to Google Sheets API for security

## Step 3: Create a Google Sheets Spreadsheet

1. Go to [Google Sheets](https://sheets.google.com/)
2. Create a new spreadsheet
3. Name it "Leather E-commerce Orders" (or any name you prefer)
4. Copy the spreadsheet ID from the URL:
   ```
   https://docs.google.com/spreadsheets/d/SPREADSHEET_ID/edit
   ```

## Step 4: Configure the App

1. Open `lib/services/google_sheets_service.dart`
2. Replace the placeholder values:
   ```dart
   static const String _apiKey = 'YOUR_GOOGLE_SHEETS_API_KEY';
   static const String _spreadsheetId = 'YOUR_SPREADSHEET_ID';
   ```

## Step 5: Set Up the Spreadsheet Structure

The app will automatically create the following columns in your spreadsheet:

| Column | Description |
|--------|-------------|
| A | Order ID |
| B | User ID |
| C | Order Date |
| D | Status |
| E | Customer Name |
| F | Phone |
| G | Address |
| H | Payment Method |
| I | Tracking Number |
| J | Subtotal |
| K | Shipping Cost |
| L | Tax Amount |
| M | Total Amount |
| N | Item Count |
| O | Items (formatted) |

## Step 6: Test the Integration

1. Run the app
2. Create a test order
3. Check your Google Sheets to see if the order appears
4. Verify all data is correctly formatted

## Features

### Automatic Order Sync
- Orders are automatically saved to Google Sheets when created
- Real-time status updates
- Complete order history tracking

### Data Management
- Customer information
- Order details and items
- Payment and shipping information
- Status tracking (Processing, Shipped, Delivered)

### Analytics Ready
- Export data for analysis
- Create charts and reports
- Integrate with other Google Workspace tools

## Security Notes

1. **API Key Security**: Never commit your API key to version control
2. **Spreadsheet Access**: Make sure only authorized users can access the spreadsheet
3. **Data Privacy**: Consider GDPR and privacy regulations for customer data

## Troubleshooting

### Common Issues

1. **403 Forbidden Error**: 
   - Check if Google Sheets API is enabled
   - Verify API key is correct
   - Ensure spreadsheet is accessible

2. **404 Not Found Error**:
   - Verify spreadsheet ID is correct
   - Check if spreadsheet exists and is accessible

3. **Data Not Appearing**:
   - Check API key permissions
   - Verify spreadsheet permissions
   - Check console logs for error messages

### Debug Mode

Enable debug logging by checking the console output when orders are created. The service will log success/failure messages.

## Advanced Configuration

### Custom Sheet Names
You can change the sheet name by modifying:
```dart
static const String _ordersSheetName = 'Your_Custom_Sheet_Name';
```

### Additional Fields
To add more fields to the spreadsheet, modify the `_formatOrderForSheets` method in the service.

## Support

If you encounter issues:
1. Check the Google Cloud Console for API usage
2. Verify spreadsheet permissions
3. Review the console logs for detailed error messages
4. Ensure all dependencies are properly installed

## Next Steps

1. Set up automated reports
2. Create order status dashboards
3. Integrate with email notifications
4. Set up data backup procedures
