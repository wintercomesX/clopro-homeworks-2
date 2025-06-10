#!/bin/bash

# Wait for services to start
sleep 30

# Create HTML page with link to bucket image
cat > /var/www/html/index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LAMP Server - Instance Group</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .server-info {
            background-color: #e7f3ff;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .image-section {
            text-align: center;
            margin: 30px 0;
        }
        .image-section img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .link-section {
            background-color: #f0f8ff;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 LAMP Server Running</h1>
        
        <div class="server-info">
            <h3>Server Information:</h3>
            <p>Server: <?php echo gethostname(); ?></p>
            <p>Current time: <?php echo date('Y-m-d H:i:s'); ?></p>
            <p><strong>Server Type:</strong> LAMP Stack (Linux, Apache, MySQL, PHP)</p>
            <p><strong>Instance Group:</strong> Yandex Cloud Instance Group</p>
        </div>
        
        <div class="image-section">
            <h3>Image from Object Storage:</h3>
            <img src="https://${bucket_domain}/${image_filename}" 
                 alt="Image from Yandex Object Storage" 
                 onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZGRkIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5OSIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPkltYWdlIG5vdCBmb3VuZDwvdGV4dD48L3N2Zz4='" />
        </div>
        
        <div class="link-section">
            <h3>Direct Link to Image:</h3>
            <p><a href="https://${bucket_domain}/${image_filename}" target="_blank">
                Open Image in New Tab
            </a></p>
        </div>
        
        <div class="server-info">
            <h3>Health Check Status:</h3>
            <p style="color: green;"><strong>✅ Server is healthy and running</strong></p>
            <p><small>This page is served by Apache web server</small></p>
        </div>
    </div>
</body>
</html>
HTML

# Set proper permissions
chown www-data:www-data /var/www/html/index.html
chmod 644 /var/www/html/index.html

# Restart Apache to ensure everything works
systemctl restart apache2
systemctl status apache2

# Create health check endpoint
cat > /var/www/html/health << 'HEALTH'
OK
HEALTH
chown www-data:www-data /var/www/html/health
chmod 644 /var/www/html/health
