# Docs

This docs describe QAPI which is an API for generating questions for a given location. It uses [Freebase](http://freebase.com/) to get information for a given location. 
Therefore an URL-Scheme can be used to get question formated as JSON.

The API follows a simple URL-Scheme. 

    /api/:latitude/:longitude/?token=<your_public_key>
    

An valid query could be "/api/52.520007/13.404954" which would produce:

    [
        {
            question: "Which genre is the music of Rammstein attributed to",
            answers: [
                {
                    answer: "Hard rock",
                    is_true: false
                },{
                    answer: "Classical music",
                    is_true: false
                },{
                    answer: "Industrial metal",
                    is_true: true
                },{
                    answer: "Serialism",
                    is_true: false
                }
            ]
        }
    ]
    

# Secret Bears are:

* Alexander Junger
* Stefan Laimer
* Thomas Mayrhofer

Together we are [secret bears](https://github.com/secretBears).
