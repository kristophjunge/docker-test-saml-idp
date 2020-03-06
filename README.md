# Docker Test SAML 2.0 Identity Provider (IdP)

[![DockerHub Pulls](https://img.shields.io/docker/pulls/kristophjunge/test-saml-idp.svg)](https://hub.docker.com/r/kristophjunge/test-saml-idp/) [![DockerHub Stars](https://img.shields.io/docker/stars/kristophjunge/test-saml-idp.svg)](https://hub.docker.com/r/kristophjunge/test-saml-idp/) [![GitHub Stars](https://img.shields.io/github/stars/kristophjunge/docker-test-saml-idp.svg?label=github%20stars)](https://github.com/kristophjunge/docker-test-saml-idp) [![GitHub Forks](https://img.shields.io/github/forks/kristophjunge/docker-test-saml-idp.svg?label=github%20forks)](https://github.com/kristophjunge/docker-test-saml-idp) [![GitHub License](https://img.shields.io/github/license/kristophjunge/docker-test-saml-idp.svg)](https://github.com/kristophjunge/docker-test-saml-idp)

![Seal of Approval](https://raw.githubusercontent.com/kristophjunge/docker-test-saml-idp/master/seal.jpg)

Docker container with a plug and play SAML 2.0 Identity Provider (IdP) for development and testing.

Built with [SimpleSAMLphp](https://simplesamlphp.org). Based on official PHP7 Apache [images](https://hub.docker.com/_/php/).

**Warning!**: Do not use this container in production! The container is not configured for security and contains static user credentials and SSL keys.

SimpleSAMLphp is logging to stdout on debug log level. Apache is logging error and access log to stdout.

The contained version of SimpleSAMLphp is 1.15.2.


## Supported Tags

- `1.15` [(Dockerfile)](https://github.com/kristophjunge/docker-test-saml-idp/blob/1.15/Dockerfile)
- `1.14` [(Dockerfile)](https://github.com/kristophjunge/docker-test-saml-idp/blob/1.14/Dockerfile)


## Changelog

See [CHANGELOG.md](https://github.com/kristophjunge/docker-test-saml-idp/blob/master/docs/CHANGELOG.md) for information about the latest changes.


## Usage
```
docker run --name=testsamlidp_idp \
-p 8081:8081 \
-e SIMPLESAMLPHP_SP_ENTITY_ID=https://gus-diagnostics.tranetechdev.com
-e SIMPLESAMLPHP_SP_ASSERTION_CONSUMER_SERVICE=https://gus-diagnostics.tranetechdev.com/api/sessions/saml/assertion
-e SIMPLESAMLPHP_SP_SINGLE_LOGOUT_SERVICE=https://gus-diagnostics.tranetechdev.com/api/sessions/saml-logout
-e SIMPLESAMLPHP_ADMIN_PASSWORD=samladmin
-e SIMPLESAMLPHP_SECRET_SALT=salt
-e SIMPLESAMLPHP_BASEURLPATH=https://gus-samlidp.tranetechdev.com/simplesaml/
-d registry.nexiabuild.com/nexia_diagnostics_saml_idp
```

## Managing users
There are currently 3 users defined in the configuration

* nexiadealer
* nexiaadmin
* nexiafsr

The password for these users is the same as the username. If you want to add or remove users 
you can edit the file https://github.com/nexiahome/docker-test-saml-idp/blob/master/config/simplesamlphp/authsources.php 

The example below is for a user that has a username and password of nexiadealer. The key of the 
hash is the username and password in the format of `username:password`
```
'nexiadealer:nexiadealer' => array(
  'GUID' => '51e97951-0cbb-4c85-ae1e-dc5f3460edce',
  'UserID' => 'NexiaDealer',
  'userFullName' => 'Christina Cho',
  'userFirstName' => 'Christina',
  'userLastName' => 'Cho',
  'userEmail' => "ccho@irco.com",
  'userPermissions' => 'Brand.Trane,Channel.IWD,Account.Dealer,Nexia.Dealer',
  'companyId' => '47ee0922-5989-4e41-9e99-d23c11fa9f5b',
  'companyName' => 'Demo IWD Customer',
  'companyPhoneNumber' => '412-293-1212',
  'companyContactEmail' => '',
  'companyAddress' => '370 Interlocken Blvd',
  'companyCity' => 'Broomfield',
  'companyState' => 'CO',
  'companyZip' => '80020',
  'companyBrand' => 'Nexia',
  'companyChannel' => '',
  'companyLogo' => ''
)
```

## Rebuilding the container
If you are running this in the diagnostics ecosystem then you will need to rebuild the
container whenerver you make changes. For example if you add a new user. To accomplish this you will
have to do the following:

1. Find the running conainer
`docker ps | grep saml and find the id for this container.`

2. Stop the container
`docker stop {that_container_id}`

3. Remove the stopped container
`docker rm {that_container_id}`

4. Rebuild the conainer
`make dev-container`



## License

This project is licensed under the MIT license by Kristoph Junge.
