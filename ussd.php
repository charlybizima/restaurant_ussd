<?php
require_once 'config.php';
require_once 'sms_helper.php';

// Debug: Check if sendSMS is available
if (!function_exists('sendSMS')) {
    error_log('sendSMS is NOT available!');
} else {
    error_log('sendSMS is available!');
}

// Get Africa's Talking USSD parameters
$sessionId = $_POST['sessionId'] ?? '';
$serviceCode = $_POST['serviceCode'] ?? '';
$phoneNumber = $_POST['phoneNumber'] ?? '';
$text = $_POST['text'] ?? '';

// Initialize response
$response = "";

// Check if user exists, if not create new user
$stmt = $conn->prepare("SELECT * FROM users WHERE phone = ?");
$stmt->bind_param("s", $phoneNumber);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows == 0) {
    $stmt = $conn->prepare("INSERT INTO users (phone) VALUES (?)");
    $stmt->bind_param("s", $phoneNumber);
    $stmt->execute();
}

// Process USSD input
if (empty($text)) {
    // Main menu
    $response = "CON Welcome to Restaurant USSD\n";
    $response .= "1. View Menu\n";
    $response .= "2. Place Order\n";
    $response .= "3. Check Order Status\n";
} else {
    $textArray = explode('*', $text);
    $level = count($textArray);

    switch ($level) {
        case 1:
            switch ($textArray[0]) {
                case '1': // View Menu
                    $response = "CON Select Category:\n";
                    $response .= "1. Main Course\n";
                    $response .= "2. Appetizers\n";
                    $response .= "3. Desserts\n";
                    $response .= "4. Beverages\n";
                    break;
                case '2': // Place Order
                    $response = "CON Enter item number to order:\n";
                    $stmt = $conn->query("SELECT id, name, price FROM menu_items WHERE is_available = 1");
                    while ($row = $stmt->fetch_assoc()) {
                        $response .= $row['id'] . ". " . $row['name'] . " - KES " . $row['price'] . "\n";
                    }
                    break;
                case '3': // Check Order Status
                    $stmt = $conn->prepare("SELECT status FROM orders WHERE customer_phone = ? ORDER BY created_at DESC LIMIT 1");
                    $stmt->bind_param("s", $phoneNumber);
                    $stmt->execute();
                    $result = $stmt->get_result();
                    if ($row = $result->fetch_assoc()) {
                        $response = "END Your last order status: " . $row['status'];
                    } else {
                        $response = "END No orders found.";
                    }
                    break;
            }
            break;
        case 2:
            if ($textArray[0] == '1') { // Menu category selected
                $category = '';
                switch ($textArray[1]) {
                    case '1': $category = 'Main Course'; break;
                    case '2': $category = 'Appetizers'; break;
                    case '3': $category = 'Desserts'; break;
                    case '4': $category = 'Beverages'; break;
                }
                
                // Debug: Log the category and query
                error_log("Selected category: " . $category);
                
                $response = "CON " . $category . " Menu:\n";
                $stmt = $conn->prepare("SELECT id, name, price FROM menu_items WHERE category = ? AND is_available = 1");
                $stmt->bind_param("s", $category);
                $stmt->execute();
                $result = $stmt->get_result();
                
                // Debug: Log the number of items found
                error_log("Number of items found: " . $result->num_rows);
                
                if ($result->num_rows > 0) {
                    while ($row = $result->fetch_assoc()) {
                        $response .= $row['id'] . ". " . $row['name'] . " - KES " . $row['price'] . "\n";
                    }
                } else {
                    $response = "END No items found in this category.";
                }
            } elseif ($textArray[0] == '2') { // Order item selected
                $itemId = $textArray[1];
                $stmt = $conn->prepare("SELECT name, price FROM menu_items WHERE id = ?");
                $stmt->bind_param("i", $itemId);
                $stmt->execute();
                $result = $stmt->get_result();
                if ($row = $result->fetch_assoc()) {
                    $response = "CON Confirm order for " . $row['name'] . " (KES " . $row['price'] . ")?\n";
                    $response .= "1. Yes\n";
                    $response .= "2. No";
                } else {
                    $response = "END Invalid item selected.";
                }
            }
            break;
        case 3:
            if ($textArray[0] == '2' && $textArray[2] == '1') { // Order confirmation
                $itemId = $textArray[1];
                $stmt = $conn->prepare("SELECT name, price FROM menu_items WHERE id = ?");
                $stmt->bind_param("i", $itemId);
                $stmt->execute();
                $result = $stmt->get_result();
                if ($row = $result->fetch_assoc()) {
                    // Create order
                    $stmt = $conn->prepare("INSERT INTO orders (customer_phone, items, total_amount) VALUES (?, ?, ?)");
                    $items = json_encode([['id' => $itemId, 'name' => $row['name'], 'price' => $row['price']]]);
                    $stmt->bind_param("ssd", $phoneNumber, $items, $row['price']);
                    $stmt->execute();
                    
                    // Send SMS directly to the customer
                    $message = "Your order for " . $row['name'] . " (KES " . $row['price'] . ") has been received! Thank you for choosing our restaurant.";
                    sendRealSMS($phoneNumber, $message);
                    
                    $response = "END Order placed successfully! You will receive an SMS confirmation shortly.";
                }
            }
            break;
    }
}

// Send response in Africa's Talking format
header('Content-type: text/plain');
echo $response;
?> 