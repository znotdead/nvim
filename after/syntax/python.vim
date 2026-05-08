syn keyword pythonClassVar self cls
syn keyword pythonReserved local nonlocal global
syn region  pythonRawString matchgroup=pythonQuotes
      \ start=+[uU]\=[rR]\=[tT]\=[fF]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell
