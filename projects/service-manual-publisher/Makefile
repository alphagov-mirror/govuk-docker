service-manual-publisher: bundle-service-manual-publisher asset-manager publishing-api content-store
	$(GOVUK_DOCKER) run $@-lite sh -c 'bin/rake db:migrate 2>/dev/null || bin/rake db:setup'
