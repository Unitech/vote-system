module HomeHelper
 def truncate_words(text, length = 30, end_string = '...')
    text[0..(length-1)] + (text.length > length ? end_string : '')
  end
end
