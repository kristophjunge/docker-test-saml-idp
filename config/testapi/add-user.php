<?php
/**
 * Add a new test user to the example-userpass authentication source
 *
 * Call this from test set up code to add a new user to test with
 */
// user - formatted as "user:pass"
$user = $_POST['user'];
// user metadata
$metadata = json_decode($_POST['metadata'], true);
// where our config is
$file = '/var/www/simplesamlphp/config/authsources.php';

// load the current config
require($file);
// append our new user
$config['example-userpass'][$user] = $metadata;
// save the new config
$contents = "<?php \$config = ".var_export($config, true).";\n";
file_put_contents($file, $contents);