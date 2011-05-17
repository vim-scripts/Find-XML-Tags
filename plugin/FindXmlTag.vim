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

com! -nargs=+ Findxmltagexact call FindXmlTag#FindXmlTag( 1, <f-args> )
com! -nargs=+ Findxmltagflexible call FindXmlTag#FindXmlTag( 0, <f-args> )
