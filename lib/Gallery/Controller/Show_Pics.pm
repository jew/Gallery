package Gallery::Controller::Show_Pics;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Show_Pics - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
	my $album_id   = $c->request->params->{album_id};
	
	my @pictures = [$c->model('DB::Picture')->search({album_id=>$album_id})];
	$c->log->debug("----------------------------------------------------->".@pictures);

 
   #$c->stash( template => 'show_albums.tt');
   $c->stash(template => 'show_pics.tt',pictures=>@pictures,album_id=>$album_id);    
}


__PACKAGE__->meta->make_immutable;

1;
