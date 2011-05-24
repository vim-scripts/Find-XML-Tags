if ( exists( "g:FindXmlTag_loaded" || &compatible || version < 700 ) )
  finish
endif

let g:FindXmlTag_loaded = 1

if ( !exists( "g:FindXmlTag_anyValue" ) )
  let g:FindXmlTag_anyValue = '`'
endif

if ( !exists( "g:FindXmlTag_noValue" ) )
  let g:FindXmlTag_noValue = '``'
endif

com! -nargs=+ FindXmlTagExact    call FindXmlTag#FindXmlTag( 1, <f-args> ) | if ( &hlsearch ) | set hlsearch | endif
com! -nargs=+ FindXmlTagFlexible call FindXmlTag#FindXmlTag( 0, <f-args> ) | if ( &hlsearch ) | set hlsearch | endif
