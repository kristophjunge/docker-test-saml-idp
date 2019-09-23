<?php

$config = array(
  'admin' => array(
    'core:AdminPassword',
  ),
  'diagnostics-sp' => array(
    'exampleauth:UserPass',
    'nexiadealer:nexiadealer' => array(
      'uid' => array('1'),
      'roles' => array('dealer'),
      'email' => 'dealer@diagnostics.com',
    ),
    'nexiaadmin:nexiaadmin' => array(
      'uid' => array('2'),
      'roles' => array('admin'),
      'email' => 'admin@diagnostics.com',
    ),
  ),

);
