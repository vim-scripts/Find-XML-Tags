" Test: cellpadding=0 cellpadding="0" cellpadding='0'
function! FindXmlTag#MakeAttributeSearchString( name, value )
  let result = '\<' . a:name

  " Only attach the value clause if the attribute HAS a value.
  if ( a:value != g:FindXmlTag_noValue )
    " If the default value is selected, replace with the default wildcard expression.
    let value = a:value == g:FindXmlTag_anyValue ? '[^''"]*' : a:value

    if ( a:value == g:FindXmlTag_anyValue )
      let result .= '\%('
    endif

    let result .= '\_s*=\_s*\%('

    let result .= '''' . value . ''''
    let result .= '\|'
    let result .= '"' . value . '"'
    let result .= '\|'
    let result .= value

    let result .= '\)'

    if ( a:value == g:FindXmlTag_anyValue )
      let result .= '\)\?'
    endif
  endif

  return result
endfunction

function! FindXmlTag#MakeTagSearchString( exact, tag, attributes )
  let result = '<' . a:tag

  if ( len( a:attributes ) > 0 )
    let numAttributes = 0

    let result .= '\%('
    let result .= '\_s\+'

    if ( !a:exact )
      let result .= '[^<>]\{-}'
    endif

    let result .= '\%('

    let i = 0

    while ( i < len( a:attributes ) )
      let name  = a:attributes[ i ]
      let value = a:attributes[ i + 1 ]

      if ( i > 0 )
        let result .= '\|'
      endif

      let result .= '\%('
      let result .= FindXmlTag#MakeAttributeSearchString( name, value )
      let result .= '\)'

      let numAttributes += 1

      let i += 2
    endwhile

    let result .= '\)'
    let result .= '\)'

    let result .= '\{' . numAttributes . '}'
  endif

  let result .= a:exact == 1 ? '\_s*' : '[^<>]\{-}'
  let result .= '\/\?>'

  return result
endfunction

" Findxmltagexact table cellspacing \d\+ cellpadding \d\+ border \d\+
" Test: <table cellpadding=0 cellspacing="0" border='0'><tr><td></td></tr></table>
"
" This should match the strict one, also.
" Findxmltagflexible table cellspacing \d\+ cellpadding \d\+ border \d\+
" Test: <table class="test" cellpadding=0 cellspacing="0" style="padding: 5px; margin: 3px;" border='0'>
function! FindXmlTag#FindXmlTag( exact, tag, ... )
  let searchString = FindXmlTag#MakeTagSearchString( a:exact, a:tag, a:000 )

  let @/ = searchString

  call histadd( '/', searchString )
endfunction
