$:<< File.dirname(__FILE__) + '/../lib'
  
require 'jruby/lucene'

require 'test/unit'
require 'rubygems'
require 'fileutils'

class IndexWriter < org.apache.lucene.index.IndexWriter; end
class IndexReader < org.apache.lucene.index.IndexReader; end
class StandardAnalyzer < org.apache.lucene.analysis.standard.StandardAnalyzer; end

class TestLucene < Test::Unit::TestCase
  INDEXPATH  = './data/0'
  DATA=[[1, "this is a test"], [2, "this is another test"]]
  def test_create_index
    FileUtils.rm_rf( INDEXPATH )
    assert !File.exists?( INDEXPATH )
    index_available = IndexReader.index_exists(INDEXPATH)
    assert_not_nil index_available
    assert_kind_of FalseClass, index_available
    writer = IndexWriter.new(INDEXPATH, StandardAnalyzer.new, !index_available)   
    index_available = IndexReader.index_exists(INDEXPATH)
    assert_kind_of TrueClass, index_available

    assert File.exists?( INDEXPATH )
    assert File.directory?( INDEXPATH )
    assert_not_nil writer
    assert_kind_of IndexWriter, writer
    writer.close
    remove_index
  end

  def test_new
    assert Object.const_defined?("Lucene")
    assert Lucene.respond_to?(:new)
    assert_nothing_raised { Lucene.new(INDEXPATH) }
    l = Lucene.new(INDEXPATH)
    assert_not_nil l
    assert_kind_of Lucene, l
  end
  def test_add_documents
    remove_index
    create_index
    l = Lucene.new(INDEXPATH)
    assert_not_nil l
    assert_kind_of Lucene, l 
    result = l.search("foo")
    assert result.kind_of?( Array ), result.inspect
    assert result.length == 0
    l.add_documents(DATA)
    query="another"
    result = l.search(query)
    assert result.kind_of?( Array ), result.inspect
    assert result.length > 0
    # [0.625, 2, "this is another test"]
    score = result[0].shift
    assert_equal DATA[1], result[0]

  end
  def test_delete_documents
    remove_index
    create_index
    l = Lucene.new(INDEXPATH)
    l.add_documents([[23, "foo bar"]])
    result = l.search("foo")
    assert_kind_of Array, result
    assert result.length == 1
    l.delete_documents([23])
    result = l.search("foo")
    assert_kind_of Array, result
    assert result.length == 0
  end
  def test_search
    l = Lucene.new(INDEXPATH)
    assert l.respond_to?(:search)
    l.add_documents([[9, "this is yet another test"]])
    result = l.search("yet")
    assert_not_nil result
    assert_kind_of Array, result
    assert result.length > 0
    assert_equal 9, result[0][1]
  end
  private
 def create_index(path=INDEXPATH)
    writer = IndexWriter.new(path, StandardAnalyzer.new, !IndexReader.index_exists(path))  
    writer.close 
   File.exists?(path)
 end
 def remove_index(path=INDEXPATH)
    IndexReader.index_exists(path) ? FileUtils.rm_rf(path) : true
 end
end
