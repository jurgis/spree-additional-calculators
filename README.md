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

  
  
TODO
----

* Add RSpec tests (need to figure out how to run them)
* Possibly add some cucumber scenarios
* Possibly use unobtrusive javascript
  
  

Copyright (c) 2011 Jurgis Jurksta, released under the New BSD License
