# Docker Test SAML 2.0 Identity Provider (IdP)

[![DockerHub Pulls](https://img.shields.io/docker/pulls/kristophjunge/test-saml-idp.svg)](https://hub.docker.com/r/kristophjunge/test-saml-idp/) [![DockerHub Stars](https://img.shields.io/docker/stars/kristophjunge/test-saml-idp.svg)](https://hub.docker.com/r/kristophjunge/test-saml-idp/) [![GitHub Stars](https://img.shields.io/github/stars/kristophjunge/docker-test-saml-idp.svg?label=github%20stars)](https://github.com/kristophjunge/docker-test-saml-idp) [![GitHub Forks](https://img.shields.io/github/forks/kristophjunge/docker-test-saml-idp.svg?label=github%20forks)](https://github.com/kristophjunge/docker-test-saml-idp) [![GitHub License](https://img.shields.io/github/license/kristophjunge/docker-test-saml-idp.svg)](https://github.com/kristophjunge/docker-test-saml-idp)

![Seal of Approval](https://raw.githubusercontent.com/kristophjunge/docker-test-saml-idp/master/seal.jpg)

Docker container with a plug and play SAML 2.0 Identity Provider (IdP) for development and testing.

Built with [SimpleSAMLphp](https://simplesamlphp.org). Based on official PHP7 Apache [images](https://hub.docker.com/_/php/).

**Warning!**: Do not use this container in production! The container is not configured for security and contains static user credentials and SSL keys.

SimpleSAMLphp is logging to stdout on debug log level. Apache is logging error and access log to stdout.

The contained version of SimpleSAMLphp is 1.14.15.

## Supported Tags

- `1.14.15` [(Dockerfile)](https://github.com/kristophjunge/docker-test-saml-idp/blob/1.14.15/Dockerfile)


## Usage

```
docker run --name=some-test-saml-idp \
-p 8080:80 \
-p 8443:443 \
-e SIMPLESAMLPHP_SP_ENTITY_ID=http://app.example.com \
-e SIMPLESAMLPHP_SP_ASSERTION_CONSUMER_SERVICE=http://localhost/simplesaml/module.php/saml/sp/saml2-acs.php/test-sp \
-e SIMPLESAMLPHP_SP_SINGLE_LOGOUT_SERVICE=http://localhost/simplesaml/module.php/saml/sp/saml2-logout.php/test-sp \
-d kristophjunge/test-saml-idp
```

There are two static users configured in the IdP with the following data:

| UID | Username | Password | Group | Email |
|---|---|---|---|---|
| 1 | user1 | user1pass | group1 | user1@example.com |
| 2 | user2 | user2pass | group2 | user2@example.com |

However you can define your own users by mounting a configuration file:

```
-v /users.php:/var/www/simplesamlphp/config/authsources.php
```

You can access the SimpleSAMLphp web interface of the IdP under `http://localhost:8080/simplesaml`. The admin password is `secret`.


## Test the Identity Provider (IdP)

To ensure that the IdP works you can use SimpleSAMLphp as test SP.

Download a fresh installation of [SimpleSAMLphp](https://simplesamlphp.org) and configure it for your favorite web server.

For this test the following is assumed:
- The entity id of the SP is `http://app.example.com`.
- The local development URL of the SP is `http://localhost`.
- The local developemnt URL of the IdP is `http://localhost:8080`.

The entity id is only the name of SP and the contained URL wont be used as part of the auth mechanism.

Add the following entry to the `config/authsources.php` file of SimpleSAMLphp.
```
    'test-sp' => array(
        'saml:SP',
        'entityID' => 'http://app.example.com',
        'idp' => 'http://localhost:8080/simplesaml/saml2/idp/metadata.php',
    ),
```

Add the following entry to the `metadata/saml20-idp-remote.php` file of SimpleSAMLphp.
```
$metadata['http://localhost:8080/simplesaml/saml2/idp/metadata.php'] = array(
    'name' => array(
        'en' => 'Test IdP',
    ),
    'description' => 'Test IdP',
    'SingleSignOnService' => 'http://localhost:8080/simplesaml/saml2/idp/SSOService.php',
    'SingleLogoutService' => 'http://localhost:8080/simplesaml/saml2/idp/SingleLogoutService.php',
    'certFingerprint' => '119b9e027959cdb7c662cfd075d9e2ef384e445f',
);
```

Start the development IdP with the command above (usage) and initiate the login from the development SP under `http://localhost/simplesaml`.

Click under `Authentication` > `Test configured authentication sources` > `test-sp` and login with one of the test credentials.


## Dynamic config during tests

In some test environments you may not know what path or even domain the SP is going to be on until after the IdP container has already started, in that case it can be useful to update config dynamically in the already running container.

No verification is done on any of these calls, if you break config with a bad call, you're on your own!

### Service Providers

It's possible add SPs dynamically by POSTing to the `simplesaml/testapi/add-sp-remote.php` script.

For documentation on how SPs can be configured, see https://simplesamlphp.org/docs/stable/simplesamlphp-reference-sp-remote .

The script requires two parameters:

 * `name` - the name of the remote, ideally it should be unique (e.g use [uniqid()](http://php.net/uniqid) as part of the name) as duplicate names will simply overwrite each other
 * `data` - configuration for this SP encoded as JSON

Example:

```
curl -d "name=foo" -d 'data={"AssertionConsumerService": "http://.../", "SingleLogoutService": "http://.../"}' -sv http://$samlContainer/simplesaml/testapi/add-sp-remote.php
```

### Users

The `simplesaml/testapi/add-user.php` script can be used to add a new user to the `example-userpass` authentication source.

The script requires two parameters:

 * `user` - the username and password formatted as `user:pass`
 * `metadata` - the metadata for the user encoded as JSON

Example:

```
curl -d "user=foo:bar" -d 'metadata={"email": "foo@example.com"}' -sv http://$samlContainer/simplesaml/testapi/add-user.php
```

## License

This project is licensed under the MIT license by Kristoph Junge.
