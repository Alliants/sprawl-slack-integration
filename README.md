# Slack integration - Making some noice coming from Sprawl

This is a very simple notification bot that will post messages to Slack
`team-top-gun` channel when receiving events from Goose.

## Installation

```
$ git clone git@github.com:Alliants/goose-server.git
$ bundle
```

## To Run locally

` $ SLACK_INTEGRATION='/services/123123123/123123123213213' bundle exec rackup`

visit

[http://localhost:9292/health](http://localhost:9292/health)

## Basic usage

This service listens to messages coming in `/notification` endpoint and
translates them into messages going to Slack.

In a production scenario, Sprawl will be configured to notify this integration
about events generated in the system.

### Configuration

A slack income hook needs to be setup in an environment variable:

`SLACK_INTEGRATION='/services/123123123/123123123213213'`

To read more about them please check [the official guide](https://api.slack.com/incoming-webhooks)
