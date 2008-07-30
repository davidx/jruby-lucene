
require "java"

require File.dirname(__FILE__) + "/../../ext/lucene-core-2.3.2.jar"

class Lucene
  VERSION = "1.0.3"
  @index_path = nil
  def initialize(an_index_path = "data/")
    @index_path = an_index_path
  end
  def add_documents(id_text_pair_array) # e.g., [[1,"test1"],[2,'test2']]
    index_available = org.apache.lucene.index.IndexReader.index_exists(@index_path)
    index_writer = org.apache.lucene.index.IndexWriter.new(
          @index_path,
          org.apache.lucene.analysis.standard.StandardAnalyzer.new,
          !index_available)
    id_text_pair_array.each {|id_text_pair|
      term_to_delete = org.apache.lucene.index.Term.new("id", id_text_pair[0].to_s) # if it exists
      a_document = org.apache.lucene.document.Document.new
      a_document.add(org.apache.lucene.document.Field.new('text', id_text_pair[1],
                       org.apache.lucene.document.Field::Store::YES,
                       org.apache.lucene.document.Field::Index::TOKENIZED))
      a_document.add(org.apache.lucene.document.Field.new('id', id_text_pair[0].to_s,
                       org.apache.lucene.document.Field::Store::YES,
                       org.apache.lucene.document.Field::Index::TOKENIZED))
      index_writer.updateDocument(term_to_delete, a_document) # delete any old docs with same id
    }
    index_writer.close
  end
  def search(query)
    parse_query = org.apache.lucene.queryParser.QueryParser.new(
         'text',
         org.apache.lucene.analysis.standard.StandardAnalyzer.new)
    query = parse_query.parse(query)
    engine = org.apache.lucene.search.IndexSearcher.new(@index_path)
    hits = engine.search(query).iterator
    results = []
    while (hits.hasNext && hit = hits.next)
      id = hit.getDocument.getField("id").stringValue.to_i
      text = hit.getDocument.getField("text").stringValue
      results << [hit.getScore, id, text]
    end
    engine.close
    results
  end
  def delete_documents id_array # e.g., [1,5,88]
    index_available = org.apache.lucene.index.IndexReader.index_exists(@index_path)
    index_writer = org.apache.lucene.index.IndexWriter.new(
          @index_path,
          org.apache.lucene.analysis.standard.StandardAnalyzer.new,
          !index_available)
    id_array.each {|id|
      index_writer.deleteDocuments(org.apache.lucene.index.Term.new("id", id.to_s))
    }
    index_writer.close
  end
end
