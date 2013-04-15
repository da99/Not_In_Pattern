require 'Not_In_Pattern/version'

def Not_In_Pattern target, regex_or_str, replace = nil, &blok
  @target = target

  def target
    @target
  end

  def index_at first, last
    target[first, last-first]
  end

  do_gsub = replace || blok
  pattern = regex_or_str
  
  offsets = []
  target.gsub(pattern) { |substr|
    offsets << $~.offset(0)
  }

  index = 0
  final = ''
  non   = []
  
  offsets.each { |pair|
    
    if pair.first > index
      piece = index_at( index, pair.first )
      non   << piece

      args = [piece, replace].compact
      final << piece.gsub(*args, &blok) if do_gsub
    end

    final << index_at( *pair ) if do_gsub
    index = pair.last
    
  }
  
  # Process remaining piece at end of String, if any, 
  # that did not match pattern.
  if index < target.size
    piece = index_at( index, target.size )
    args = [piece, replace].compact
    final << piece.gsub(*args, &blok) if do_gsub
    non   << piece
  end

  do_gsub ?
    final :
    non

end # === def Not_In_Pattern



