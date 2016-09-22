library(httr)

endpts <- oauth_endpoint(authorize = "https://orcid.org/oauth/authorize",
                         access = "https://pub.orcid.org/oauth/token")

myapp <- oauth_app("rorcid",
                   key = Sys.getenv("ORCID_CLIENT_ID"),
                   secret = Sys.getenv("ORCID_CLIENT_SECRET"))

tok <- oauth2.0_token(endpts, myapp, scope = "/authenticate")

# 4. Use API
ortoken <- config(token = tok)
req <- GET("https://pub.orcid.org/v1.2/search/orcid-bio?q=johnson%20cardiology%20houston",
           add_headers(Authorization = paste0('Bearer ', tok$credentials$access_token)),
           accept('application/orcid+json'),
           verbose())
stop_for_status(req)
jsonlite::fromJSON(content(req, "text"))

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)
