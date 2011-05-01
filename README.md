Additional Spree Calculators
============================

This gem contains additional calculators for [Spree Comerce](http://spreecommerce.com)

Currently there is only a single calculator implemented but the infrastructure allows to easily add more.

* WeightAndQuantity calculator determines the shipping and handling cost based on total
item weigh and number or items in the order.
  
  

Usage
----

Add following line to your Rails 3 application:

    gem 'spree_additional_calculators'
  
And then run:

    $ bundle
    $ rake spree_additional_calculators:install



Copyright (c) 2011 Jurgis Jurksta, released under the New BSD License
