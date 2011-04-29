use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;

BEGIN { use_ok 'Catalyst::Test', 'Gallery' }
BEGIN { use_ok 'Gallery::Controller::Album;' }
use ok 'Test::WWW::Mechanize::Catalyst' => 'Gallery';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
#test for login
$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'jew');
$mech->field('password', 'jewabc');
$mech->submit_form_ok();

#test add comment and show comment 
$mech->get_ok('http://localhost:3000/comment/showcomment?picture_id=1');
$mech->title_is("Show Comment");
$mech->find_all_images();
$mech->get_ok('http://localhost:3000/comment/add?picture_id=1');
$mech->field('comment',"TEST COMMENT FROM t");
$mech->submit_form_ok();

#test sub index
$mech->get_ok('http://localhost:3000/comment/?picture_id=1');
$mech->title_is("Show Comment");
$mech->find_all_images();
$mech->content_contains("TEST COMMENT FROM t");
$mech->followable_links(url_regex => qr/picture\/1\/delete/i );

#test delete comment
$mech->get_ok("http://localhost:3000/comment/1/delete?comment_id=69");
$mech->title_is("Delete comment");
$mech->content_like(qr/Confirm to delete comment./);
$mech->submit_form_ok();
#$mech->redirect_ok();


done_testing();
