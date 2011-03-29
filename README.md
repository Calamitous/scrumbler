Scrumbler
=========

Scrumbler will scramble any bit of text you feed it such that the first and last letters stay the same, but everything else is scrambled.

What?
=====

In 2003, Cambridge researchers discovered that words scrambled such that

    Aoccdrnig to rscheearch at Cmabrigde uinervtisy, it deosn't mttaer waht
    oredr the ltteers in a wrod are, the olny iprmoetnt tihng is taht the frist
    and lsat ltteres are at the rghit pclae. The rset can be a tatol mses and
    you can sitll raed it wouthit a porbelm. Tihs is bcuseae we do not raed
    ervey lteter by it slef but the wrod as a wlohe.

In other news, the Cambridge research meme may be bunkum: http://www.snopes.com/language/apocryph/cambridge.asp

Installation
------------

Scrumbler is a gem:

    gem install scrumbler

Usage
-----

First, you should require the gem:

    require 'rubygems'
    require 'scrumbler'

Once this is done, Scrumbler can be activated in a number of ways.  You can use a class method:

    Scrumbler.scrumble('The quick brown fox jumps over the lazy dog.')

     => "The qucik bworn fox jupms oevr the lazy dog."

...or instatiate it:

    Scrumbler.new('The quick brown fox jumps over the lazy dog.').scrumbled

     => "The qucik bworn fox jmups over the lazy dog."

... or, if you're feeling naughty, you can ask Scrumbler to monkeypatch String:

    'The quick brown fox jumps over the lazy dog.'.scrumble

    NoMethodError: undefined method `scrumble' for "The quick brown fox jumps over the lazy dog.":String

    Scrumble.release_the_monkeys!
    'The quick brown fox jumps over the lazy dog.'.scrumble

     => "The qciuk bowrn fox jpmus over the lazy dog." 

== Contributing to scrumbler
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2011 Eric Budd. See LICENSE.txt for further details.

