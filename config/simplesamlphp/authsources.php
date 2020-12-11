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

    /*In this mode there are 3 users user1, user2, user3 which belong to
    group1, group2 and group1 and group2 respectively*/
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
        'user3:user3pass' => array(
            'uid' => array('3'),
            'eduPersonAffiliation' => array('group1','group2'),
            'email' => 'user3@example.com',
        ),
    )
);
