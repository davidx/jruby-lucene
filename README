# jruby-lucene

* http://github.com/davidx/jruby-lucene/tree

## DESCRIPTION:

A jruby wrapper for lucene. Packaged after initial blog post by Mark Watson,
here : http://markwatson.com/blog/2007/06/using-lucene-with-jruby.html

## FEATURES/PROBLEMS:

* Currently a basic prototype only

## SYNOPSIS:

require 'rubygems'
require 'jruby/lucene'

lucene = Lucene.new(INDEX_PATH='./data')

# search

result = lucene.search("testing 123")
p result.inspect

# add documents

lucene.add_documents(id_text_pair_array) # e.g., [[1,"test1"],[2,'test2']]

* delete documents

lucene.delete_documents(id_array) # e.g., [1,5,88]

== REQUIREMENTS:

* simple wrapper jruby lucene demonstration

## INSTALL:

 /usr/local/jruby/bin/rake build
 /usr/local/jruby/bin/gem install jruby-lucene

## LICENSE:

(The MIT License)

Copyright (c) 2008 Mark Watson, David Andersen

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
