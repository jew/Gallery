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
#Test /album
$mech->get_ok('http://localhost:3000/album',);
$mech->title_is( "Show Album" );
$mech->content_contains("ALL ALBUMS :",
        "Check for user show album");
#test add 
$mech->get_ok('http://localhost:3000/album/add');
$mech->title_is( "Add New Album" );
$mech->field('album_name','TEST FROM t');
$mech->submit_form_ok();
$mech->content_contains(" Successful! to Add album","Test content from add album");
$mech->follow_link( n => 1 );
$mech->follow_link( url_regex => qr/home/i);

#test view
$mech->get_ok( 'http://localhost:3000/album/3/view');
$mech->title_is("View Your Album");
#$mech->find_image();
$mech->find_all_images();
$mech->follow_link( url_regex => qr/album\/3\/viewall/i );

#test view all
$mech->get_ok('http://localhost:3000/album/3/viewall','SUB VIEW ALL ALBUM ');
$mech->title_is("View/Comment");
$mech->find_all_images();
$mech->followable_links(url_regex => qr/comment?picture_id=1/i );

#test showall
$mech->get_ok('http://localhost:3000/album/showall','SUB SHOW ALL ALBUM '); 
$mech->title_is("View Other Album");
$mech->find_all_images();
$mech->follow_link( url_regex => qr/viewall/i);
        
#test delete 
$mech->get_ok('http://localhost:3000/album/5/delete','SUB DELETE ALBUM '); 
$mech->title_is( "Delete Album" );
$mech->content_contains("Confirm to delete Album",
        "Check for delete");

done_testing();
