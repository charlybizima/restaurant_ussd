<?php
require_once 'config.php';
session_start();

if (!isset($_SESSION['admin_logged_in'])) {
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $username = $_POST['username'] ?? '';
        $password = $_POST['password'] ?? '';
        
        if ($username === 'admin' && $password === 'admin123') {
            $stmt = $conn->prepare("SELECT * FROM users WHERE name = ? AND role = 'manager'");
            $stmt->bind_param("s", $username);
            $stmt->execute();
            $result = $stmt->get_result();
            if ($result->num_rows > 0) {
                $_SESSION['admin_logged_in'] = true;
                $_SESSION['admin_role'] = 'manager';
            } else {
                $error = "You are not authorized as a manager.";
            }
        } else {
            $error = "Invalid credentials";
        }
    }
    
    if (!isset($_SESSION['admin_logged_in'])) {
        ?>
        <!DOCTYPE html>
        <html>
        <head>
            <title>Restaurant Admin Login</title>
            <style>
                body { font-family: Arial, sans-serif; margin: 40px; }
                .login-form { max-width: 300px; margin: 0 auto; }
                input { width: 100%; padding: 8px; margin: 10px 0; }
                button { width: 100%; padding: 10px; background: #4CAF50; color: white; border: none; cursor: pointer; }
            </style>
        </head>
        <body>
            <div class="login-form">
                <h2>Admin Login</h2>
                <?php if (isset($error)) echo "<p style='color: red'>$error</p>"; ?>
                <form method="POST">
                    <input type="text" name="username" placeholder="Username" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit">Login</button>
                </form>
            </div>
        </body>
        </html>
        <?php
        exit;
    }
}

// Only allow managers to access the admin panel
if (!isset($_SESSION['admin_role']) || $_SESSION['admin_role'] !== 'manager') {
    echo "<h2>Access Denied</h2><p>You must be a manager to access this page.</p>";
    exit;
}

// Handle order approval/rejection
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $orderId = $_POST['order_id'];
    $action = $_POST['action'];
    $status = ($action === 'approve') ? 'approved' : 'rejected';
    
    $stmt = $conn->prepare("UPDATE orders SET status = ? WHERE id = ?");
    $stmt->bind_param("si", $status, $orderId);
    $stmt->execute();
    
    // Get order details for SMS
    $stmt = $conn->prepare("SELECT customer_phone, items FROM orders WHERE id = ?");
    $stmt->bind_param("i", $orderId);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($row = $result->fetch_assoc()) {
        $message = "Your order has been $status. Thank you for choosing our restaurant!";
        sendSMS($row['customer_phone'], $message);
    }
}

// Get pending orders
$orders = $conn->query("SELECT * FROM orders WHERE status = 'pending' ORDER BY created_at DESC");
?>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Admin Panel</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background: #f5f5f5; }
        .action-btn { padding: 5px 10px; margin: 0 5px; cursor: pointer; }
        .approve { background: #4CAF50; color: white; border: none; }
        .reject { background: #f44336; color: white; border: none; }
    </style>
</head>
<body>
    <h1>Pending Orders</h1>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Customer Phone</th>
            <th>Items</th>
            <th>Total Amount</th>
            <th>Created At</th>
            <th>Action</th>
        </tr>
        <?php while ($order = $orders->fetch_assoc()): ?>
        <tr>
            <td><?php echo $order['id']; ?></td>
            <td><?php echo $order['customer_phone']; ?></td>
            <td><?php echo $order['items']; ?></td>
            <td>$<?php echo $order['total_amount']; ?></td>
            <td><?php echo $order['created_at']; ?></td>
            <td>
                <form method="POST" style="display: inline;">
                    <input type="hidden" name="order_id" value="<?php echo $order['id']; ?>">
                    <button type="submit" name="action" value="approve" class="action-btn approve">Approve</button>
                    <button type="submit" name="action" value="reject" class="action-btn reject">Reject</button>
                </form>
            </td>
        </tr>
        <?php endwhile; ?>
    </table>
</body>
</html> 