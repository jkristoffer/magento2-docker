<?php
return array (
  'cache' => [
    'frontend' => [
	'page_cache' => [
		'backend' => 'Cm_Cache_Backend_Redis',
		'backend_options' => [
			'server' => '127.0.0.1',
			'port' => '6379',
			'persistent' => '',
			'database' => 0,
			'password' => '',
			'force_standalone' => 0,
			'connect_retries' => 1,
		],
 	 ],
    ],
  ],
  'backend' => 
  array (
    'frontName' => 'admin_1e3x3b',
  ),
  'install' => 
  array (
    'date' => 'Sun, 10 Jan 2016 03:54:17 +0000',
  ),
  'crypt' => 
  array (
    'key' => '009b63f8bad644c9b4f3ed093e25fec4',
  ),
  'session' => 
  array (
    'save' => 'db',
  ),
  'db' => 
  array (
    'table_prefix' => 'mage',
    'connection' => 
    array (
      'default' => 
      array (
        'host' => 'mysql',
        'dbname' => 'magento2',
        'username' => 'root',
        'password' => 'magento2',
        'model' => 'mysql4',
        'engine' => 'innodb',
        'initStatements' => 'SET NAMES utf8;',
        'active' => '1',
      ),
    ),
  ),
  'resource' => 
  array (
    'default_setup' => 
    array (
      'connection' => 'default',
    ),
  ),
  'x-frame-options' => 'SAMEORIGIN',
  'MAGE_MODE' => 'default',
  'cache_types' => 
  array (
    'config' => 1,
    'layout' => 1,
    'block_html' => 1,
    'collections' => 1,
    'reflection' => 1,
    'db_ddl' => 1,
    'eav' => 1,
    'config_integration' => 1,
    'config_integration_api' => 1,
    'full_page' => 1,
    'translate' => 1,
    'config_webservice' => 1,
  ),
);
