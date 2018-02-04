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
-p 8080:8080 \
-p 8443:8443 \
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
- The local development URL of the IdP is `http://localhost:8080`.

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


## Contributing

See [CONTRIBUTING.md](https://github.com/kristophjunge/docker-test-saml-idp/blob/master/docs/CONTRIBUTING.md) for information on how to contribute to the project.

See [CONTRIBUTORS.md](https://github.com/kristophjunge/docker-test-saml-idp/blob/master/docs/CONTRIBUTORS.md) for the list of contributors.


## License

This project is licensed under the MIT license by Kristoph Junge.
