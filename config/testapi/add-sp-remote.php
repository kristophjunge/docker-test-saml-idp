<?php
/**
 * Add a new SP remote
 *
 * Call this from test set up code to enable whatever dynamic URL the code under
 * test is running on to be used via the SimpleSAML IdP.
 */
// name of the SP remote (ideally unique)
$name = $_POST['name'];
// configuration data for the SP remote
$data = json_decode($_POST['data'], true);
// where our config is
$file = '/var/www/simplesamlphp/metadata/saml20-sp-remote.php';
// lets just append to the $metadata array
$contents = file_get_contents($file);
$contents .= "\$metadata[".var_export($name, true)."] = ".var_export($data, true).";\n";
file_put_contents($file, $contents);