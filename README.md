[![Build Status](https://travis-ci.org/secretBears/QAPI.svg?branch=master)](https://travis-ci.org/secretBears/QAPI)


# QAPI (Question API)
QAPI is an API that provides location based computer-generated question/answer sets. The semantic web contains vast amounts of data that we wanted to transform into knowledge which can be used by developers for their next fancy quiz game. We also invented a cool buzzword for this concept: data driven games - go tell your friends.

## Is it free
Yes it is. That is, it's free until everybody has been enslaved and can no longer live without QAPI. At that point we will change to a lucrative pay-per-request plan. ;)

Awesome. How can I use it?

## Usage

QAPI provides results based on a simple GET query to <code>/api/{longitude}/{latitude}</code>. So if you want questions for the center of the world, just call

```
get /api/0/0
```

Easy...

### But will it JSON?
QAPI returns it's result as a JSON object in the following format:

```
{
  "id":20,
  "question":"Frage 20",
  "place":"Linz",
  "answers":[{
     "answer":"20 answer 1",
     "is_true":false
   },{
      "answer":"20 answer 2",
      "is_true":true
   },{
      "answer":"20 answer 3",
      "is_true":false
   },{
      "answer":"20 answer 4",
      "is_true":false
   }]
}
```


### Public API
There will be a public API which can be used for your own application, without hosting your own QAPI. More information will be available soon.


## Custom Rake Tasks

There are a few built in Rake-Tasks for development.

### Clear Caches
QAPI has a built in Cache which can be cleared by the following tasks:

```
    rake cache:clear:all        # clears all caches (questions and places)
    rake cache:clear:places     # clears all places
    rake cache:clear:questions  # clears all questions
```

### Regenerate Keys

QAPI uses travis-ci for automatic deployment to heroku. The secret and API keys are stored in config/application.yml and are not checked in VCS.
There is a sample application.yml file in the config directory. For regenerating the ENV variables on travis.yml and Heroku there is a rake task to do that.

```
    rake regenerate_keys        # regenerates all keys on heroku and travis.yml
```



## Contributors
This awesome project is powered by secret bears.

* Alex Junger
* Thomas Mayrhofer ([webpapaya](http://www.twitter.com/webpapaya))
* Stefan Laimer

Give them a cookie.