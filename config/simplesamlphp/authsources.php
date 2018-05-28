<?php

$config = array(

    'admin' => array(
        'core:AdminPassword',
    ),

    'example-userpass' => array(
        'exampleauth:UserPass',
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
    ),

    'x509' => array(
        'authX509toSAML:X509userCert',
        'authX509toSAML:cert_name_attribute' => 'CN',
        'authX509toSAML:assertion_name_attribute' => 'displayName',
        'authX509toSAML:assertion_dn_attribute' => 'distinguishedName',
        'authX509toSAML:assertion_o_attribute' => 'o',
        'authX509toSAML:assetion_assurance_attribute' => 'eduPersonAssurance',
        'authX509toSAML:parse_san_emails' => true,
        'authX509toSAML:parse_policy' => true,
        'authX509toSAML:export_eppn' => false,
    )

);
