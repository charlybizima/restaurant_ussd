<?php
require_once 'config.php';

$result = $conn->query("SELECT * FROM menu_items");

echo "<h2>Menu Items in Database:</h2>";
echo "<table border='1'>";
echo "<tr><th>ID</th><th>Name</th><th>Category</th><th>Price</th><th>Available</th></tr>";

while ($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>" . $row['id'] . "</td>";
    echo "<td>" . $row['name'] . "</td>";
    echo "<td>" . $row['category'] . "</td>";
    echo "<td>KES " . $row['price'] . "</td>";
    echo "<td>" . ($row['is_available'] ? 'Yes' : 'No') . "</td>";
    echo "</tr>";
}
echo "</table>";

$result = $conn->query("SELECT DISTINCT category FROM menu_items");
echo "<h2>Available Categories:</h2>";
echo "<ul>";
while ($row = $result->fetch_assoc()) {
    echo "<li>" . $row['category'] . "</li>";
}
echo "</ul>";

$conn->close();
?> 