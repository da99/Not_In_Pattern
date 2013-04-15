
Not\_In\_Pattern
================

A Ruby gem inspired by: [http://www.ruby-forum.com/topic/157102#692145](http://www.ruby-forum.com/topic/157102#692145)

It gives you all the stuff not matched by a regular expression.

Installation
------------

    gem install Not_In_Pattern

Usage
------

    require "Not_In_Pattern"
    
    Not_In_Pattern "We went to Austria, land of Austrians", %r!Austria!
    # --> ['We went to ', ', land of ', 'ns']

    Not_In_Pattern "Run Mike Run", %r!\s*Run\s*!, "Spot"
    # --> "Run Spot Run"

    Not_In_Pattern "Tokyo Jones & Tokyo Mike", %r!\s*Tokyo\s*! do |replace|
      replace.split.map { |str|
        case str
        when 'Jones'
          'Jonesy'
        when 'Mike'
          'Mikey'
        else
          str
        end
      }.join ' '
    end
    # --> "Tokyo Jonesy and Tokyo Mikey"

Run Tests
---------

    git clone git@github.com:da99/Not_In_Pattern.git
    cd Not_In_Pattern
    bundle update
    bundle exec bacon spec/lib/main.rb

Know of a better way?
-----------------------------

If you know of existing software that makes the above redundant,
please tell me. The last thing I want to do is maintain code.

