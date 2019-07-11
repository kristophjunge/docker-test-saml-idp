<?php

/**
 * @file
 * Used to define the test SAML user accounts.
 */

$config = [
    'admin' => [
        'core:AdminPassword',
    ],
    'example-userpass' => [
        'exampleauth:UserPass',
        'user1:user1pass' => [
            'uid' => ['1'],
            'eduPersonAffiliation' => ['group1'],
            'email' => 'user1@example.com',
        ],
        'user2:user2pass' => [
            'uid' => ['2'],
            'eduPersonAffiliation' => ['group2'],
            'email' => 'user2@example.com',
        ],
    ],
];
