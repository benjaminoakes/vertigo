Vertigo
=======

A simple Ruby wrapper around the VerticalResponse API ("VRAPI").

Vertigo makes working with the VerticalResponse SOAP API much more Ruby-like.  It manages your session_id, as well as letting you write methods as launch_email_campaign rather than launchEmailCampaign, and use symbols as keys rather than strings.

Author: Benjamin Oakes <hello@benjaminoakes.com>, @benjaminoakes

Installation
------------

Simply add Vertigo to your Gemfile:

    gem 'vertigo'

If you are unlucky enough not to be using Bundler:

    gem install vertigo

Usage
-----

Basic usage example:

    require 'vertigo'
    
    session_duration_minutes = 4
    client = Vertigo::Client.new('username', 'password', session_duration_minutes)

    # Launch a campaign whose ID you already know:
    client.launch_email_campaign(:campaign_id => campaign_id)

Contributing
------------

To set up your development environment, run `bash dev-setup.sh`.

Thanks
------

* Forrest Chang (@fkchang2000) for the name
