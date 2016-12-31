<?php
/**
 * SAML 2.0 remote SP metadata for SimpleSAMLphp.
 *
 * See: https://simplesamlphp.org/docs/stable/simplesamlphp-reference-sp-remote
 */

$metadata[((getenv('SIMPLESAMLPHP_ENTITY_ID') != '') ? getenv('SIMPLESAMLPHP_ENTITY_ID') : 'https://app.example.com')] = array(
    'AssertionConsumerService' => getenv('SIMPLESAMLPHP_ASSERTION_CONSUMER_SERVICE'),
    'SingleLogoutService' => getenv('SIMPLESAMLPHP_SINGLE_LOGOUT_SERVICE'),
);
