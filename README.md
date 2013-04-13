# Pingdom Widget for Status Board

This Sinatra app can be used to pull in the current status of a service
check from the [Pingdom](http://pingdom.com) service and display it on your
[Status Board](http://panic.com/statusboard).

## Configuration

To configure your own instance of this widget, you should be familiar with
running Sinatra or Ruby on Rails instances. Of course, if you are not familiar
with setting up and running a Sinatra web application, the easiest route is to
use [Heroku](http://heroku.com). Please reference [this tutorial](https://devcenter.heroku.com/articles/git)
for more information about deploying to Heroku.

### Defining Your Credentials

In addition to your email and password, you will need to get an application key
from the Pingdom control panel.

Once you have your application key, you should update the `app.rb` file to include it, along with your credentials, like so:

    set :email, "<your Pingdom email address>"
    set :password, "<your Pingdom password>"
    set :app_key, "<your application key>"

Defining the app key is optional, however, as you can always pass it to the
app with the app_key request parameter. For example:

    https://<your-deployment-location>/check/<your-check-id>?app_key=<your-app-key>

## Usage

Currently, the only supported endpoint is the Check endpoint. More endpoints
may be added soon.

To use, simply add a custom widget to your Status Board with a URL similar to
the following:

    https://<your-deployment-location>/check/<your-check-id>

If you have not specified your application key in `app.rb`, your URL should
look like:

    https://<your-deployment-location>/check/<your-check-id>?app_key=<your-app-key>

## Author

Written by Justin Mecham ([email](mailto:justin@mecham.me),
[twitter](http://twitter.com/jsmecham)).

## License

This project is licensed under the terms of the MIT License.
