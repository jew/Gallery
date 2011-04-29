use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;

BEGIN { use_ok 'Catalyst::Test', 'Gallery' }
BEGIN { use_ok 'Gallery::Controller::Album;' }
#specify the name of this  app 
use ok 'Test::WWW::Mechanize::Catalyst' => 'Gallery';
#create two users to simulate
my $ua1 = Test::WWW::Mechanize::Catalyst->new;
my $ua2 = Test::WWW::Mechanize::Catalyst->new;
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
$mech->get_ok("http://localhost:3000/", "Check redirect of base URL") for $ua1, $ua2;

#test for  login
$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'jew');
$mech->field('password', 'jewabc');
$mech->submit_form_ok();



#Upload picture
$mech->get_ok('http://localhost:3000/picture/add');
$mech->field('album_id', '1');
$mech->field('imagepath','/home/jew/Desktop/pic test/dog13.jpg');
$mech->field('imagename','good day');
$mech->field('description','What s a beautiful day ');
$mech->submit_form_ok();
$mech->content_contains("Upload complete!",
        "Check for upload") for $ua1, $ua2;
$mech->title_is("Upload Picture");
 
#test for delete : change number
$mech->get_ok('http://localhost:3000/picture/64/delete');
$mech->title_is( "Delete Picture" );
$mech->content_contains("Confirm to delete Picture",
        "Check for delete");
$mech->find_all_images();
#$mech->submit_form_ok();
ok( request('/login')->is_success, 'Request should succeed');
done_testing();
