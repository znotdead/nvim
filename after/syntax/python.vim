syn keyword pythonBuiltin self
syn region  pythonRawString matchgroup=pythonQuotes
      \ start=+[uU]\=[rR]\=[fF]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell
