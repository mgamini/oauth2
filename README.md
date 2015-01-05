OAuth2
======

> OAuth2 Library for Elixir

### Usage
So far, I only have one situation coded out: utilizing an access code with Google's OAuth2 (https://developers.google.com/accounts/docs/OAuth2)

## Registration
Start by registering an oauth strategy:

# Simple example:
* This is the same as the multiple strategies example below, it simply sets its name to :default*
```elixir
params = %{
  client_id: "someid12345",
  client_secret: "somesecret12345",
  redirect_uri: "http://whatever.com/oauth",
  token_endpoint: "https://www.googleapis.com/oauth2/v3/token"
}
OAuth2.register(params)
# > :ok
```

# Multiple strategies:
```elixir
params1 = %{
  client_id: "someid12345",
  client_secret: "somesecret12345",
  redirect_uri: "http://whatever.com/oauth",
  token_endpoint: "https://www.googleapis.com/oauth2/v3/token"
}
params2 = %{
  client_id: "someid12345",
  client_secret: "somesecret12345",
  redirect_uri: "http://whatever.com/oauth",
  token_endpoint: "https://someotherservice.com/oauth"
}
OAuth2.register(:google, params1)
# > :ok
OAuth2.register(:other, params2)
# > :ok
```

# Utilizing a discovery service:
```elixir
params = %{
  client_id: "someid12345",
  client_secret: "somesecret12345",
  redirect_uri: "http://whatever.com/oauth"
}
discovery_uri = "https://accounts.google.com/.well-known/openid-configuration"

OAuth2.register(:google, params, discovery_uri)
# > :ok
```

## Authorizing Users
```elixir
OAuth2.authorize_user("access_code_asdfasdfasdfasdfasdf")
# >  {:ok,
# >   %OAuth2.Response{
# >    body: %{access_token: "asdfasdfasdfasdfsadfasdfasdf",
# >      expires_in: 3600,
# >      id_token: "asdfsadfsadfsadfsadfsadfsadfsadfsadfsadfasdfasdfa",
# >      token_type: "Bearer"},
# >    headers: [{"Cache-Control", "no-cache, no-store, max-age=0, must-revalidate"},
# >     {"Pragma", "no-cache"}, {"Expires", "Fri, 01 Jan 1990 00:00:00 GMT"},
# >     {"Date", "Mon, 05 Jan 2015 22:49:06 GMT"}, {"Vary", "Origin"},
# >     {"Vary", "X-Origin"}, {"Content-Type", "application/json; charset=UTF-8"},
# >     {"X-Content-Type-Options", "nosniff"}, {"X-Frame-Options", "SAMEORIGIN"},
# >     {"X-XSS-Protection", "1; mode=block"}, {"Server", "GSE"},
# >     {"Alternate-Protocol", "443:quic,p=0.02"}, {"Transfer-Encoding", "chunked"}],
# >    status_code: 200
# >    }
# >  }
```
or
```elixir
OAuth2.authorize_user(:strategy_name, "codecodecode")
```
