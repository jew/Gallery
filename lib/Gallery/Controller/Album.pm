package Gallery::Controller::Album;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Album - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0){
    my ( $self, $c, $album_id ) = @_;
    my $login_user = $c->user->user_id;
    my $albums_rs = $c->model('DB::Album')->search_rs( { user_id => $login_user } );
    use Data::Dumper;
    while ( my $album = $albums_rs->next() ) {
		my $picture = $album->pictures()->first(); #First picture for each album
		next if !$picture;
		$c->log->debug($c->model('Thumbnail')->thumbmake( Gallery->path_to('/root/gallery') . '/' . $picture->path ));
    }
    $c->stash( albums_rs => $albums_rs);
    $c->stash( template  => 'album/list.tt' );
}

=head3 base
=cut
sub base :Chained('/') :PathPart('album') :CaptureArgs(1){
    my ( $self, $c, $album_id ) = @_;
    my $login_user = $c->user->user_id;
    my $album      = $c->model('DB::Album')->find({album_id=>$album_id});
    $c->stash(albums => [$c->model('DB::Album')->search({user_id=>$login_user})]);
    #Thumbnail
    my $thumb = $c->model('DB::Picture')->first();
    next if !$thumb;
    my $pic = Gallery->path_to('/root/gallery') . '/' . $thumb->thumbnail;
	$c->log->debug("---------->".$pic); 
	$c->model('Thumbnail')->thumbmake($pic);
	$c->log->debug("--------->".$thumb->thumbnail); 
	$c->stash(thumbnail => $thumb->thumbnail); 
    $c->stash(album => $album);
}

=head4 add
add album 
=cut

sub add :Local :Args(0){
    my ( $self, $c ) = @_;
   	my $album_name = $c->request->param('album_name');
   	my $userid = $c->user->user_id;
    if($c->request->method eq 'POST') {
		my $r =  $c->model('DB::Album')->create({
			album_name => $album_name,
			user_id => $userid
		});	
			if($r->album_id) {
				$c->stash(statusmsg => " Successful! to Add album");	
			}
     
			$c->log->debug("Debug link".$r->album_id);
	  } 
		$c->stash(template => 'album/add_album.tt');
}
=head5 view
view album of user 
menu : View your album->click on album then show pic
=cut

sub view :Chained('base') :PathPart('view') :Args(0){
    my ( $self, $c ) = @_;
    my $album = $c->stash->{album};
    #get album_id from chain 
	my @pictures = [$c->model('DB::Picture')->search({album_id=>$album->album_id()})];
	#$c->log->debug("----------------------------------------------------->".@pictures);
    $c->stash(template => 'album/show_pics.tt',pictures=>@pictures,album=>$album);  
}

=head6 viewall
view other album and can comment 
view pictures 
=cut
sub viewall :Chained('base') :PathPart('viewall') :Args(0){
    my ( $self, $c ) = @_;
    my $album = $c->stash->{album};
	my @pictures = [$c->model('DB::Picture')->search({album_id=>$album->album_id()})];
	$c->log->debug("----------------------------------------------------->".@pictures);
    $c->stash(template => 'album/showpics.tt',pictures=>@pictures,album=>$album);  
}

=head7 delete

=cut

sub delete :Chained('base') :PathPart('delete') :Args(0){
    my ( $self, $c ) = @_;
    my $album_id   = $c->stash->{album_id};
    my $login_user = $c->user->user_id;
    my $album = $c->model('DB::Album')->search({user_id=>$login_user});
    if($c->req->method eq 'POST') {
        $c->stash->{album}->delete;
        $c->stash(albums=>$album);
        $c->response->redirect($c->uri_for('/album'));
    }
    else {
        $c->stash(title    => 'Delete album');
        $c->stash(template => 'album/
    delete.tt');
    }; 
    
=head 8 showall
From menu : view other album
shows album of other user
=cut
sub showall :Local :Args(0){
	my ( $self, $c) = @_;
	my $login_user = $c->user->user_id;
	my $albums_rs = $c->model('DB::Album');
    #Search for album from albumid
     while ( my $album = $albums_rs->next() ) {
         my $picture = $album->pictures()->first(); #First picture for each album
         next if !$picture;
         $c->model('Thumbnail')->thumbmake( Gallery->path_to('/root/gallery') . '/' . $picture->path );
     }
    $c->stash( albums_rs => $albums_rs);
    $c->stash( template  => 'album/showall.tt' );      
}
=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
}
__PACKAGE__->meta->make_immutable;

1;
