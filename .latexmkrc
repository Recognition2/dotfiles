     
$compiling_cmd = 'makeglossaries %R';
add_cus_dep( 'nlo', 'nls', 0, 'makenlo2nls' );
sub makenlo2nls {
system( "makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"" );
}
add_cus_dep( 'glo', 'gls', 0, 'makeglo2gls' );
sub makeglo2gls {
system( "makeindex -s nomencl.ist -o \"$_[0].gls\" \"$_[0].glo\"" );
}
