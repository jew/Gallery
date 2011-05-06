package Gallery::Model::Thumb;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Model';

=head1 NAME

Gallery::Model::Thumb - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

=head2 thumbmake 
  Create thumb by passing filename --> thumbnailmake($filename)
  Return thumnail filename
=cut

sub thumbmake  {
  my ( $self, $file ) = @_;

  my $format;

  # see Imager::Files for information on the read() method
  #die($file);
  my $img = Imager->new(file=>$file)
    or die Imager->errstr();

  $file =~ s/\.[^.]*$//;

  # Create smaller version
  # documented in Imager::Transformations
 # my $thumb = $img->scale(scalefactor=>.3);
  my $thumb = $img->scale(xpixels=>96, ypixels=>96);
  

  # Autostretch individual channels
  $thumb->filter(type=>'autolevels');

  # try to save in one of these formats
  SAVE: 
    for my $format ( qw( png gif jpeg tiff ppm ) ) {
    # Check if given format is supported
    if ($Imager::formats{$format}) {
      $file.="_low.$format";
      #print "Storing image as: $file\n";
      # documented in Imager::Files
      $thumb->write( file => $file ) or
        die $thumb->errstr;
      last SAVE;
    }
  }
 
}
__PACKAGE__->meta->make_immutable;

1;
