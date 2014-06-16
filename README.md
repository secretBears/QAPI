[![Build Status](https://travis-ci.org/secretBears/QAPI.svg?branch=master)](https://travis-ci.org/secretBears/QAPI)

# QAPI (Question API)
QAPI is an API that provides location based computer-generated question/answer sets. The semantic web contains vast amounts of data that we wanted to transform into knowledge which can be used by developers for their next fancy quiz game. We also invented a cool buzzword for this concept: data driven games - go tell your friends.

## Public API

There is a public free Version of this API hosted on [qapi.herokuapp.com](http://qapi.herokuapp.com) which requires an API Key which will be generated when one is registred.
There are currently no usage limitations.

## Is it free
Yes it is. That is, it's free until everybody has been enslaved and can no longer live without QAPI. At that point we will change to a lucrative pay-per-request plan. ;)

## API

Awesome. How can I use it?

### Get a Question

To get a question simply call:
```
    GET /api/<latitude>/<longitude>/?token=<your_api_token>
```

If you are logged in the api_token is not required so you can call.

```
    GET /api/<latitude>/<longitude>
```

### Report a Problem

QAPI generates questions to a given location. We cannot excactly say which question will be created when calling the api.
If you find a problem feel free to let us know.

```
    /api/report/<question_id>
```


### But will it JSON?
QAPI returns it's result as a JSON object in the following format:

```
[
    {
        question: "Which genre is the music of Led Zeppelin attributed to",
        answers: [
            {
                answer: "Hard rock",
                is_true: true
            },{
                answer: "Classical music",
                is_true: false
            },{
                answer: "Industrial metal",
                is_true: false
            },{
                answer: "Serialism",
                is_true: false
            }
        ]
    }
]
```


## Custom Rake Tasks

There are a few built in Rake-Tasks for development.

### Clear Caches
QAPI has a built in Cache which can be cleared by the following tasks:

```
    rake cache:clear:all        # clears all caches (questions and places)
    rake cache:clear:places     # clears all places
    rake cache:clear:questions  # clears all questions
    rake cache:clear:old        # clears all old questions which are older than the question ttl (can be used by heroku scheduler)
```

### Regenerate Keys

QAPI uses travis-ci for automatic deployment to heroku. The secret and API keys are stored in config/application.yml and are not checked in VCS.
There is a sample application.yml file in the config directory. For regenerating the ENV variables on travis.yml and Heroku there is a rake task to do that.

```
    rake regenerate_keys        # regenerates all keys on heroku and travis.yml
```

## A word on extensions of Ruby or Rails

All custom extensions of Ruby or Rails are located in lib/custom_*. All directories in lib which start with a "custom_" prefix are autoloaded to rails.

There are a few custom exceptions in lib/custom_exceptions.rb

ActiveRecord::Validations lack in some validators which are important for QAPI (e.g. JSON Validator). They are located in lib/custom_validations
 
 
## Contributors
This awesome project is powered by secret bears.

* Alex Junger ([webnitrat](http://webnitr.at/))
* Stefan Laimer ([slaimer](http://twitter.com/stlaimer))
* Thomas Mayrhofer ([webpapaya](http://thomas.mayrhofer.at/))

Give them a cookie.

## Other QAPI related Projects

There is a fully playable [game](https://github.com/secretBears/qapi-game)  which uses QAPI.

