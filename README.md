Additional Spree Calculators
============================

This gem contains additional calculators for [Spree Commerce](http://spreecommerce.com)

Currently there is only a single calculator implemented but the infrastructure allows to easily add more.

* "Weight And Quantity" calculator determines the shipping and handling cost based on total
item weigh and number or items in the order.
  
  

Usage
----

Add the following line to your Rails 3 application:

    gem 'spree_additional_calculators'
  
And then run:

    $ bundle
    $ rake spree_additional_calculators:install

  
  
Development
-----------

In order to add a new calculator or fix a bug in existing one you will need both the spree source
and the extension source locally on your computer.

    $ git clone https://jurgis@github.com/jurgis/spree-additional-calculators.git spree_additional_calculators
    $ git clone https://github.com/spree/spree.git

You can test the extension by executing following commands:

    $ cd spree_additional_calculators
    $ rake test_app SPREE_PATH='../spree'
    $ rake
  
  
TODO
----

* Find and fix outstanding issues with spree 0.50.2 (the extension worked with spree 0.11.x)
* Publish the gem 0.1.0
* Add RSpec tests
* Possibly add some cucumber scenarios
* Possibly use unobtrusive javascript
  
  

Copyright (c) 2011 Jurgis Jurksta, released under the New BSD License
