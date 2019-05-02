<?php

$users = array(
        'user1:user1pass' => array(
            'uid' => array('1'),
            'eduPersonAffiliation' => array('group1'),
            'email' => 'user1@example.com',
        ),
        'user2:user2pass' => array(
            'uid' => array('2'),
            'eduPersonAffiliation' => array('group2'),
            'email' => 'user2@example.com',
        ),
    );
if (getenv('SIMPLESAMLPHP_USERS') != '') {
    $decoded = json_decode(getenv('SIMPLESAMLPHP_USERS'), TRUE);
    $users = $decoded? $decoded : $users;
}

$config = array(

    'admin' => array(
        'core:AdminPassword',
    ),

    'example-userpass' => array('exampleauth:UserPass') + $users

);
