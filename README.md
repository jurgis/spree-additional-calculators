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
    $ rake db:migrate

Then go to [Configuration](http://localhost:3000/admin/configurations) and choose [Shipping Methods](http://localhost:3000/admin/shipping_methods)
And you will be able to select a new calculator - **Weight and Quantity**
Create the calculator and define the **Default item weight**.
That value will be used if you do not have defined the weight for your products.

After that you can go to [Configuration](http://localhost:3000/admin/configurations) and choose
[Additional Calculator Rates](http://localhost:3000/admin/additional_calculator_rates)
Click **Edit** and you will be able to add new or edit/remove existing weight and quantity ranges.

*This page is using Javascript to add and remove items in the browser. The changes are made only when you press the* **Update** *button.*

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
  
  
Screenshots
-----------

There are some [screenshots](https://github.com/jurgis/spree-additional-calculators/wiki/Screenshots) in the wiki.
  
  
TODO
----

* Possibly add some cucumber scenarios
* Possibly use unobtrusive javascript
  
  

Copyright (c) 2011 Jurgis Jurksta, released under the New BSD License
