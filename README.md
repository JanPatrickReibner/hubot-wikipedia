Fork from hubot-wikipedia for german usage

# hubot-wikipedia-german

A Hubot script for interacting with [Wikipedia's API](https://de.wikipedia.org/w/api.php) (searching for articles and returning extracts).

See [`src/wikipedia.coffee`](src/wikipedia.coffee) for full documentation.

## Installation
Download the wikipedia.coffee and place it under <hubot>/src. 


## Commands

Command | Listener ID | Description
--- | --- | ---
hubot wiki search `query` | `wikipedia.search` | Returns the first 5 Wikipedia articles matching the search `query`
hubot wiki summary `article` | `wikipedia.summary` | Returns a one-line description about `article`


## Sample Interaction

```
user1>> hubot wiki summary clean room design
hubot>> Clean room design: Clean room design (also known as the Chinese wall technique) is the method of copying a design by reverse engineering and then recreating it without infringing any of the copyrights and trade secrets associated with the original design. Clean room design is useful as a defense against copyright and trade secret infringement because it relies on independent invention.
hubot>> Original article: https://en.wikipedia.org/wiki/Clean%20room%20design
```
