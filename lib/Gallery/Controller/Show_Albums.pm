package Gallery::Controller::Show_Albums;
use Moose;
use namespace::autoclean;
use DBI;
use DBIx::Class::ResultSet;
 use Imager;
 
BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::ShowPic - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODShttp://search.cpan.org/~lgoddard/Image-Magick-Thumbnail-0.06b/lib/Image/Magick/Thumbnail.pm

=cut


=head2 index:Book

=cut

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    #Search for album from albumid
    my @albums = [$c->model('DB::Album')->all];
    #$c->log->debug("albums->".@albums);
    $c->stash(albums => @albums);
    
    
   #my @pics = [$c->model('DB::Picture')->all];
    
    #$c->stash( template => 'showpic.tt',pics => @pics);
  
     #my $thumb = $c->model('DB::Picture')->first();
     use Data::Dumper;
     $c->log->debug("----------------------->". Dumper( @albums) );
     my $thumb = $c->model('DB::Picture')->first();
     
     #$c->log->debug("----------------------->". Dumper( Gallery->path_to('/gallery/') . $picture->path) );
     #my $pic = Gallery->path_to('/root/gallery') . '/' . $picture->path;
     my $pic = Gallery->path_to('/root/gallery') . '/' . $thumb->thumbnail;
     $c->log->debug("---------->".$pic); 
     $c->model('Thumbnail')->thumbmake($pic);
     $c->log->debug("--------->".$thumb->thumbnail); 
     #$c->stash( template => 'showpic.tt',thumbnail => $thumb->thumbnail);
    $c->stash( template => 'show_albums.tt',thumbnail => $thumb->thumbnail);    
    
}   
    
__PACKAGE__->meta->make_immutable;

1;
