use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;

BEGIN { use_ok 'Catalyst::Test', 'Gallery' }
BEGIN { use_ok 'Gallery::Controller::Login;' }
use ok 'Test::WWW::Mechanize::Catalyst' => 'Gallery';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
#test for failed login
$mech->get_ok( 'http://localhost:3000/login');
$mech->title_is("Login");
$mech->field('username', 'jew');
$mech->field('password', 'jewabc');
$mech->submit_form_ok();
ok( request('/login')->is_success, 'Request should succeed' );





done_testing();
