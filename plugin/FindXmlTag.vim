if ( exists( "g:FindXmlTag_loaded" || &compatible || version < 700 ) )
  finish
endif

let g:FindXmlTag_loaded = 1

com! -nargs=+ Findxmltagexact call FindXmlTag#FindXmlTag( 1, <f-args> )
com! -nargs=+ Findxmltagflexible call FindXmlTag#FindXmlTag( 0, <f-args> )
