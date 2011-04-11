package Gallery::Controller::Upload;
use Moose;
use namespace::autoclean;
use Catalyst qw/Upload::Image::Magick/; 

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
    my $upload = $c->request->upload('picture');
    
    #if ($upload->is_image) {
      #$c->log->debug("width : " . $upload->width);
      #$c->log->debug("height : " . $upload->height);
    #}

    #$c->response->body('Matched Gallery::Controller::Upload in Upload.');
     $c->stash(template => 'upload.tt');
}

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;
__PACKAGE__->config( uploadtmp => '/root/static/gallery' );

1;
