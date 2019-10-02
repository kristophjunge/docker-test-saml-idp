dev-container:
	docker build --rm --tag=registry.nexiabuild.com/nexia_diagnostics_saml_idp .
push-container:
	docker push registry.nexiabuild.com/nexia_diagnostics_saml_idp

