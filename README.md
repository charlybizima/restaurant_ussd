# Restaurant USSD System

A simple USSD-based restaurant ordering system that allows customers to view the menu and place orders, while managers can approve orders through an admin panel.

## Features

- USSD menu interface for customers
- Menu categorization (Main Course, Appetizers, Desserts, Beverages)
- Order placement and tracking
- Admin panel for order management
- SMS notifications for order status

## Setup Instructions

1. Create a MySQL database and import the schema:
   ```sql
   mysql -u root -p < database.sql
   ```

2. Import sample data:
   ```sql
   mysql -u root -p < sample_data.sql
   ```

3. Configure the database connection in `config.php`:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USER', 'your_username');
   define('DB_PASS', 'your_password');
   define('DB_NAME', 'restaurant_ussd');
   ```

4. Set up your USSD gateway:
   - Configure your USSD gateway to point to `ussd.php`
   - Make sure your web server can handle POST requests
   - Test the USSD flow using a USSD simulator or real device

5. Configure SMS integration:
   - Open `sms_helper.php`
   - Replace the placeholder SMS gateway code with your actual SMS gateway integration
   - Update the API key and other credentials
   - Uncomment the SMS sending code

6. Access the admin panel at `admin.php`
   - Default credentials:
     - Username: admin
     - Password: admin123
   - Change these credentials in production

## Testing the System

1. USSD Testing:
   - Dial your USSD code (e.g., *123#)
   - Follow the menu prompts
   - Test ordering different items
   - Check order status

2. Admin Panel Testing:
   - Login to admin panel
   - View pending orders
   - Approve/reject orders
   - Check if SMS notifications are sent

## USSD Menu Flow

1. Main Menu:
   - 1. View Menu
   - 2. Place Order
   - 3. Check Order Status

2. View Menu:
   - 1. Main Course
   - 2. Appetizers
   - 3. Desserts
   - 4. Beverages

3. Place Order:
   - Select item number
   - Confirm order

## Security Notes

- Change the default admin credentials in `admin.php`
- Implement proper SMS gateway integration
- Add additional security measures as needed
- Use HTTPS for the admin panel
- Implement proper input validation and sanitization
- Regularly backup your database

## Requirements

- PHP 7.0 or higher
- MySQL 5.6 or higher
- USSD gateway
- SMS gateway
- Web server (Apache/Nginx)
- SSL certificate (for production)

## Troubleshooting

1. Database Connection Issues:
   - Check database credentials in `config.php`
   - Ensure MySQL service is running
   - Verify database and tables exist

2. USSD Issues:
   - Check web server logs
   - Verify USSD gateway configuration
   - Test USSD endpoint with Postman

3. SMS Issues:
   - Check SMS gateway credentials
   - Verify phone number format
   - Check error logs for SMS failures 