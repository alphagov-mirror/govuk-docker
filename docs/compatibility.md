# Compatibility

The following apps are supported by govuk-docker to some extent.

   - ✅ asset-manager
   - ❌ bouncer
   - ⚠ cache-clearing-service
      * Tests pass
      * Queues are not set-up, so cache-clearing-service can't be run locally
   - ⚠ calculators
      * Web UI doesn't work without the content item being present in the content-store.
   - ✅ calendars
   - ❌ ckan
      * Has a [separate](https://github.com/alphagov/docker-ckan) Docker project.
   - ⚠  collections
      * You will need to [populate the Content Store database](#mongodb) or run the live stack in order for it to work locally.
      * To view topic pages locally you still need to use the live stack as they rely on Elasticsearch data which we are yet to be able to import.
   - ✅ collections-publisher
   - ✅ contacts-admin
   - ⚠ content-data-admin
      * **TODO: Missing support for a webserver stack**
   - ❌ content-data-api
   - ✅ content-publisher
   - ✅ content-store
   - ✅ content-tagger
   - ❌ datagovuk_find
   - ❌ datagovuk_publish
   - ✅ email-alert-api
   - ✅ email-alert-frontend
   - ❌ email-alert-service
   - ❌ feedback
   - ✅ finder-frontend
   - ❓ frontend
   - ✅ gds-api-adapters
   - ✅ government-frontend
   - ✅ govspeak
   - ✅ govuk_app_config
   - ✅ govuk_publishing_components
   - ✅ govuk-cdn-config
   - ❓ govuk-content-schemas
      * Project exists in govuk-docker but is untested
   - ✅ govuk-developer-docs
   - ❌ hmrc-manuals-api
   - ❌ imminence
   - ✅ info-frontend
   - ✅ licence-finder
   - ⚠ link-checker-api
      * Works in isolation but not in other projects' `e2e` stacks, so must be run in a separate process.
        See https://github.com/alphagov/govuk-docker/issues/174 for details.
   - ⚠  local-links-manager
      * Only the `lite` stack is available, since that was all that was required at the point of adding.
   - ✅ manuals-frontend
   - ❌ manuals-publisher
   - ✅ mapit
      * TODO: Data replication.
   - ✅ maslow
   - ✅ miller-columns-element
   - ✅ plek
   - ✅ publisher
   - ✅ publishing-api
   - ✅ release
   - ✅ router
   - ✅ router-api
   - ✅ search-admin
   - ✅ search-api
   - ✅ service-manual-frontend
   - ❌ service-manual-publisher
   - ✅ short-url-manager
   - ✅ signon
   - ✅ smart-answers
   - ✅ specialist-publisher
   - ⚠ static
      * JavaScript 404 errors when previewing pages, possibly [related to analytics](https://github.com/alphagov/static/blob/master/app/assets/javascripts/analytics/init.js.erb#L28)
   - ✅ support
   - ✅ support-api
   - ✅ transition
   - ✅ travel-advice-publisher
   - ⚠ whitehall
      * Who knows, really - several tests are failing, lots pass ;-)
      * Rake task to [create a test taxon](https://github.com/alphagov/whitehall/blob/master/lib/tasks/taxonomy.rake#L11) for publishing is not idempotent
      * Placeholder images don't work as missing proxy for [/government/assets](https://github.com/alphagov/whitehall/blob/master/app/presenters/publishing_api/news_article_presenter.rb#L133)
