<?php
/**
 * SAML 2.0 remote SP metadata for SimpleSAMLphp.
 *
 * See: https://simplesamlphp.org/docs/stable/simplesamlphp-reference-sp-remote
 */

if (getenv('SIMPLESAMLPHP_SP_METADATA') != '') {
    $sp_metadata = json_decode(getenv('SIMPLESAMLPHP_SP_METADATA'), TRUE);
    foreach ($sp_metadata as $entity_id => $values) {
        $metadata[$entity_id] = $values;
    }
} else {
    $metadata[getenv('SIMPLESAMLPHP_SP_ENTITY_ID')] = array(
        'AssertionConsumerService' => getenv('SIMPLESAMLPHP_SP_ASSERTION_CONSUMER_SERVICE'),
        'SingleLogoutService' => getenv('SIMPLESAMLPHP_SP_SINGLE_LOGOUT_SERVICE'),
);
}




