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
$mech->get_ok('http://localhost:3000/picture/35/delete');
$mech->get_ok('http://localhost:3000/picture/add?imagename=/home/jew/Desktop/pic test/dog_wallpaper.jpg&imagepath=tst&album_id=4&description=test');

done_testing();
