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
    
    #$c->stash(albums => [$c->model('DB::Album')->search({user_id=>$login_user})]);
    #$c->stash(template => 'album/list.tt');
    
    
    
    
    
    
    #Search for album from albumid
    my @albums = [$c->model('DB::Album')->search({user_id=>$login_user})];
    #$c->log->debug("albums->".@albums);\
    
    
   #my @pics = [$c->model('DB::Picture')->all];
    
    #$c->stash( template => 'showpic.tt',pics => @pics);
  
     #my $thumb = $c->model('DB::Picture')->first();
     
     my $albums_rs = $c->model('DB::Album')->search_rs( { user_id => $login_user } );
     use Data::Dumper;
     
     
     while ( my $album = $albums_rs->next() ) {
         my $picture = $album->pictures()->first(); #First picture for each album
         next if !$picture;
         $c->model('Thumbnail')->thumbmake( Gallery->path_to('/root/gallery') . '/' . $picture->path );
     }
     
     
     #my $thumb = $c->model('DB::Picture')->first();
     
     #$c->log->debug("----------------------->". Dumper( Gallery->path_to('/gallery/') . $picture->path) );
     #my $pic = Gallery->path_to('/root/gallery') . '/' . $picture->path;

    # $c->log->debug("---------->".$pic); 
     #$c->model('Thumbnail')->thumbmake($pic);
     #$c->log->debug("--------->".$thumb->thumbnail); 
     #$c->stash( template => 'showpic.tt',thumbnail => $thumb->thumbnail);
    $c->stash( albums_rs => $albums_rs);
    $c->stash( template  => 'album/list.tt' );
    
}

=head2 index

=cut

sub base :Chained('/') :PathPart('album') :CaptureArgs(1){
    my ( $self, $c, $album_id ) = @_;
    my $login_user = $c->user->user_id;
    my $album      = $c->model('DB::Album')->find({album_id=>$album_id});
    
    $c->stash(albums => [$c->model('DB::Album')->search({user_id=>$login_user})]);
    
    
    
    
    
     #Thumbnail
     my $thumb = $c->model('DB::Picture')->first();
     #$c->log->debug("----------------------->". Dumper( Gallery->path_to('/gallery/') . $picture->path) );
     #my $pic = Gallery->path_to('/root/gallery') . '/' . $picture->path;
     my $pic = Gallery->path_to('/root/gallery') . '/' . $thumb->thumbnail;
     $c->log->debug("---------->".$pic); 
     $c->model('Thumbnail')->thumbmake($pic);
     $c->log->debug("--------->".$thumb->thumbnail); 
     #$c->stash( template => 'showpic.tt',thumbnail => $thumb->thumbnail);
     
    
   
    
    
    
    
    $c->stash(thumbnail => $thumb->thumbnail); 
    $c->stash(album => $album);
    $c->stash(template => 'album/list.tt');
}

=head2 add

=cut

sub add :Local :Args(0){
    my ( $self, $c ) = @_;
    
    
    my $submit = $c->request->params->{'submit'};	
  
   	my $album_name = $c->request->param('album_name');
   	my $userid = $c->user->user_id;
	#my $links = $c->model('DB::Album')->search_rs( { user_id => 1 }, {order_by => 'album_id DESC'})->single();
	#my $link = $links->album_id;
	#$c->log->debug("max user id === $link");

	# TODO: FIX this. This will only work for one user, since max should be unique for all users
	# and now it is only finding the max id for this user.
	my $links = $c->model('DB::Album')->search_rs( { user_id => $userid });
	my $album_ids = $links->get_column('album_id');
	my $maxalbum_id = $album_ids->max;
	$c->log->debug("maxalbum_id === $maxalbum_id");
	my $max;
	if($maxalbum_id ==0){
		$max = 1;
	}
	else {
		$max = $maxalbum_id+1;
	}
	
	my $album_id = 0;
	if($c->request->method eq 'POST')	{
		my $r = $links->search({album_name => $album_name })->next;
		if (!$r) {
			$r =  $links->create({
				album_id   => $max,
				album_name => $album_name,
			});
		}
		if($r->album_id) {
			$c->stash(statusmsg => " Successful! to Add album");
			$album_id = $r->album_id;
			
		}
		$c->log->debug("Debug link".$r->album_id);
	  }
   
     $c->stash(template => 'album/add_album.tt',albumname=>$album_name,album_id=>$album_id,userid=>$userid);
}


=head2 index

=cut

sub view :Chained('base') :PathPart('view') :Args(0){
    my ( $self, $c ) = @_;
    my $album = $c->stash->{album};
	my @pictures = [$c->model('DB::Picture')->search({album_id=>$album->album_id()})];
	$c->log->debug("----------------------------------------------------->".@pictures);
    $c->stash(template => 'album/show_pics.tt',pictures=>@pictures,album=>$album);  
}

=head2 index

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
    

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
}
__PACKAGE__->meta->make_immutable;

1;
