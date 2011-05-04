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
from menu : View your album 
Show user's album
=cut

sub index :Path :Args(0) {
    my ( $self, $c, $album_id ) = @_;
    my $login_user = $c->user->user_id;
    my $albums_rs  = $c->model('DB::Album')->search_rs( { user_id => $login_user } ); #ResultSet
    $c->stash( albums_rs => $albums_rs );
    $c->stash( title     => 'Show Album' );
}

=head2 base
=cut
sub base :Chained('/') :PathPart( 'album' ) :CaptureArgs(1) {
    my ( $self, $c, $album_id ) = @_;
    my $login_user = $c->user->user_id;
    $c->stash( album => $c->model( 'DB::Album' )->find( $album_id ) );
}

=head2 add
add album 
=cut

sub add :Local :Args(0) {
    my ( $self, $c ) = @_;
   	my $album_name = $c->request->param( 'album_name' );
   	my $userid = $c->user->user_id;
    if( $c->request->method eq 'POST' ) {
        my $r =  $c->model( 'DB::Album' )->create( {
            album_name => $album_name,
            user_id => $userid
        } );	
        if( $r->album_id ) {
            $c->stash( statusmsg => " Successful! to Add album" );	
            $c->stash( title => 'Add New Album' );
        }
        $c->log->debug( "Debug album_id".$r->album_id ) if $c->debug;
    }
    $c->stash( title => 'Add New Album' );
}
=head2 view
view album of user 
menu : View your album->click on album then show pic
=cut

sub view :Chained('base') :PathPart('view') :Args(0) {
    my ( $self, $c ) = @_;
    my $album = $c->stash->{album};
    #get album_id from chain 
	my $pictures_rs = $c->model( 'DB::Picture' )->search( { album_id => $album->album_id() } ) ;
    $c->stash( 
               pictures_rs => $pictures_rs,
               album => $album,
               album_id => $album->album_id() );  
    $c->stash( title => "View Your Album" );
}

=head2 viewall
view other album and can comment 
view pictures 
=cut
sub viewall :Chained('base') :PathPart('viewall') :Args(0) {
    my ( $self, $c ) = @_;
    my $album = $c->stash->{album};
    my $pictures_rs = $c->model( 'DB::Picture' )->search( { album_id => $album->album_id() } );
    $c->stash( 
               pictures_rs  => $pictures_rs,
               album     => $album );  
    $c->stash( title => "View/Comment" );
}

=head2 delete

=cut

sub delete :Chained('base') :PathPart('delete') :Args(0) {
    my ( $self, $c ) = @_;
    #my $album_id   = $c->stash->{album_id};
    if( $c->req->method eq 'POST' ) {
        $c->stash->{album}->delete;
        $c->response->redirect( $c->uri_for( '/album' ) );
    }
    else {
        $c->stash( title => 'Delete Album' )
    }; 
}   
=head2 showall
From menu : view other album
shows album of other user
=cut
sub showall :Local :Args(0) {
    my ( $self, $c) = @_;
    my $login_user = $c->user->user_id;
    my $albums_rs = $c->model('DB::Album');
    $c->stash( albums_rs => $albums_rs );
    $c->stash( title     => "View Other Album" );
}
=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
