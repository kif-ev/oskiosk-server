[![Build Status](https://img.shields.io/travis/kif-ev/oskiosk-server.svg?style=flat)](https://travis-ci.org/kif-ev/oskiosk-server)
[![Code Climate](https://img.shields.io/codeclimate/github/kif-ev/oskiosk-server.svg?style=flat)](https://codeclimate.com/github/kif-ev/oskiosk-server)
[![Test Coverage](https://img.shields.io/codeclimate/coverage/github/kif-ev/oskiosk-server.svg?style=flat)](https://codeclimate.com/github/kif-ev/oskiosk-server)
[![Dependency Status](https://img.shields.io/gemnasium/kif-ev/oskiosk-server.svg?style=flat)](https://gemnasium.com/kif-ev/oskiosk-server)

[Live API Docs](http://kif-ev.github.io/oskiosk-server/)

# License

This software is distributed under the MIT license, see the included
LICENSE.txt or [the OSI page about the MIT
license](http://opensource.org/licenses/MIT) for more information.

# Installation

Some knowledge of how to install and serve a Rails/Rack application is highly
recommended!

* Grab a copy of the program, change dir to that copy,
* Install dependencies: `bundle install`,
* Copy the `config/database.yml_example` to `config/database.yml` and edit as
  needed,
* Create the database if necessary: `rake db:create` (CAUTION: this will
  create the database defined in the `production` section of the
  `database.yml`),
* Populate the database: `rake db:migrate`,
* Serve the app however you see fit (if you use Apache or Nginx, the simplest
  to set up is probably [Passenger](https://www.phusionpassenger.com), your
  mileage may vary).

# Operation

## Create a new OAuth token

```sh
rake oauth:create_app[NAME(,TYPE)]
```

(Depending on your shell the `[]` might need separate escaping)

Parameters:
* `NAME`: The name of the application/token to create. This is mostly relevant
  for logging. It is recommended to create one for each station/checkout
  point, but the names can fit your current naming scheme for other stuff, as
  only operators will see this name.
* `TYPE` (optional): The type of operations permitted. By default/when left
  blank this will create a checkout-capable token. Other possible values are
  `deposit` for a token that will allow deposits to a user's account, or
  `admin` for a token that will basically allow everything.
