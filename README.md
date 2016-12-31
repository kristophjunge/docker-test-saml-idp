# Docker SAML IdP

Docker container with a plug and play SAML 2.0 IdP for development and testing.

Built with SimpleSAMLPhp and based on official PHP7 Apache images.

Warning: Do not use this container in production!

SimpleSAMLPhp is logging to stdout on debug log level.

Apache is logging error and access log to stdout.

There are two static users configured in the IdP with the following data:

user1
user1pass
1
group1
user1@example.com


However you can define your own users by mounting a configuration file:

```
-v /users.php:/var/www/simplesamlphp/config/simplesamlphp/authsources.php
```


```
docker run --name=some-saml-idp \
-e SIMPLESAMLPHP_ENTITY_ID=https://app.localhost \
-e SIMPLESAMLPHP_ASSERTION_CONSUMER_SERVICE=https://app.localhost/simplesaml/module.php/saml/sp/saml2-acs.php/test-sp \
-e SIMPLESAMLPHP_SINGLE_LOGOUT_SERVICE=https://app.localhost/simplesaml/module.php/saml/sp/saml2-logout.php/test-sp \
-d kritophjunge/saml-idp
```





Cert Fingerprint: 119b9e027959cdb7c662cfd075d9e2ef384e445f
