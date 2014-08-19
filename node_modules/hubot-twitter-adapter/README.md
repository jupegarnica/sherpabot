# Hubot Twitter Adapter

made by jupegarnica.com
working on [sherpabot](https://twitter.com/sherpaBot)


## Description

This is the [Twitter](http://twitter.com) adapter for hubot that allows you to
send an tweet to your Hubot and he will send an tweet back with the response.
And more.

## Usage

You will need to set some environment variables to use this adapter.

### Heroku

    % heroku config:add HUBOT_TWITTER_KEY="key"
    % heroku config:add HUBOT_TWITTER_SECRET="secret"
    % heroku config:add HUBOT_TWITTER_TOKEN="token"
    % heroku config:add HUBOT_TWITTER_TOKEN_SECRET="secret"

### Non-Heroku environment variables

    % export HUBOT_TWITTER_KEY="key"
    % export HUBOT_TWITTER_SECRET="secret"
    % export HUBOT_TWITTER_TOKEN="token"
    % export HUBOT_TWITTER_TOKEN_SECRET="secret"

Then you will need to set the HTTP endpoint on Twitter to point to your server
and make sure the request type is set to `GET`.

## Contribute

Just send pull request if needed or fill an issue !

## Copyright

Copyright &copy; jupegarnica. See LICENSE for details.
