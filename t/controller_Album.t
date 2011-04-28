use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;

BEGIN { use_ok 'Catalyst::Test', 'Gallery' }
BEGIN { use_ok 'Gallery::Controller::Album;' }
use ok 'Test::WWW::Mechanize::Catalyst' => 'Gallery';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
#test for failed login
$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'jew');
$mech->field('password', 'jewabc');
$mech->submit_form_ok();
$mech->get_ok('http://localhost:3000/album',);
$mech->get_ok( 'http://localhost:3000/login');
$mech->get_ok('http://localhost:3000/album/5/delete','SUB DELETE ALBUM '); 
$mech->get_ok('http://localhost:3000/album/5/view','SUB VIEW ALBUM '); 
$mech->get_ok('http://localhost:3000/album/5/viewall','SUB VIEW ALL ALBUM ');
$mech->get_ok('http://localhost:3000/album/showall','SUB SHOW ALL ALBUM ');  
$mech->get_ok('http://localhost:3000/album/add','SUB ADD ALBUM '); 
done_testing();
