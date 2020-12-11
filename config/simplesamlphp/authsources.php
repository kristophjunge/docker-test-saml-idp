<?php

$config = array(

    'admin' => array(
        'core:AdminPassword',
    ),

    'example-static' => [
  	/* This maps to modules/exampleauth/lib/Auth/Source/Static.php */
 	 'exampleauth:StaticSource',

	  /* The following is configuration which is passed on to
	   * the exampleauth:StaticSource authentication source. */
          'uid' => array('1'),
          'eduPersonAffiliation' => array('group1'),
          'email' => 'user1@example.com',
  	],

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
    )
);
