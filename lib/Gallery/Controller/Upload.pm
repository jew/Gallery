package Gallery::Controller::Upload;
use Moose;
use namespace::autoclean;
use URI::Escape;
use File::Basename;
use Catalyst qw/Request::Upload/;
#use Catalyst qw/Upload::Image::Magick/; 

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

Gallery::Controller::Upload - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut
sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
   
    # Retrieve the values from the form
	# my $imagepath   = $c->request->params->{imagepath}    || '';
	my $imagename   = $c->request->params->{imagename}    || '';
	my $description   = $c->request->params->{description}    || '';
	#my $albumid   = $c->request->params->{albumid}    || 0;
   	my $upload = $c->request->upload('imagepath');
    
    #my $imagegallerypath = $c->config->{'imagegallerypath'};
   
    
    #Use random name in gallery folder / store imagename in DB
    #my $upload_result = $c->$upload->copy_to($imagegallerypath);
 	#$c->log->debug($imagegallerypath);
 	# $c->log->debug("imagepath -----> ".$imagepath);
 	$c->log->debug("imagename -----> ".$imagename);
 	$c->log->debug("basename= ".$upload->tempname);
 	#$c->log->debug($imagepath);
    
    #$c->stash(template => 'upload.tt',result=> $imagepath,des => $description);
    $c->stash(template => 'upload.tt');
}



=head1 AUTHOR

jew,,,,
ef02e5339c4a5193f6b7476a76a77f77040cdb2e
=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;


1;
