<?php
$serviceContainer = \Propel\Runtime\Propel::getServiceContainer();
$serviceContainer->checkVersion('2.0.0-dev');
$serviceContainer->setAdapterClass('default', 'pgsql');
$manager = new \Propel\Runtime\Connection\ConnectionManagerSingle();
$manager->setConfiguration(array (
    'settings' =>
        array (
            'charset' => 'utf8',
            'queries' =>
                array (
                    'utf8' => 'SET NAMES \'UTF8\'',
                ),
        ),
    'classname' => 'Propel\\Runtime\\Connection\\ConnectionWrapper',
    'dsn' => 'pgsql:host=localhost port=5432 dbname=educational_panel',
    'user' => 'postgres',
    'password' => '123',
));
$manager->setName('default');
$serviceContainer->setConnectionManager('default', $manager);
$serviceContainer->setDefaultDatasource('default');
