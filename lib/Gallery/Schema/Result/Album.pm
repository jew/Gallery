package Gallery::Schema::Result::Album;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Imager;
use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';




__PACKAGE__->table("albums");
	


__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Gallery::Schema::Result::Album

=cut


=head1 ACCESSORS

=head2 album_id

  data_type: 'integer'
  is_nullable: 0

=head2 album_name

  data_type: 'varchar'
  is_nullable: 1

=head2 created_date

  data_type: 'datetime'
  default_value: CURRENT_DATE
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "album_id",
  { data_type => "integer", is_auto_increment => 1},
  "album_name",
  { data_type => "varchar", is_nullable => 1 },
  
  "created_date",
  {
    data_type     => "datetime",
    default_value => \"CURRENT_DATE",
    is_nullable   => 1,
  },
  "user_id",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("album_id");
#set relationships
__PACKAGE__-> belongs_to( "user","Gallery::Schema::Result::User",
{ user_id => "user_id"},);
__PACKAGE__-> has_many( "pictures" => 'Gallery::Schema::Result::Picture',
{"foreign.album_id"=>"self.album_id"},
);
# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-04-12 13:56:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gCf6kkiNryGAXIO9g17cFg

# You can replace this text with custom code or comments, and it will be preserved on regeneration

=head2 get_thumbnail
get file and send to thumbmake
=cut
sub get_thumbnail {
    my $self = shift;
    my $picture = $self->pictures()->first(); #First picture for each album
    #use Data::Dumper;
    #Dumper("Picture value" . $picture); 
    return if !$picture ;
    my $file = Gallery->config->{'imagefallerypath'} . '/' . $picture->path;
    #die($file);
    $self->thumbmake($file);
};
=head2 thumbnail
get first picture from the Pictures table 
=cut
sub	thumbnail {
    my $self = shift;
    $self->get_thumbnail();
    $self->pictures->first()->thumbnail;
}
=head2 thumbmake 

=cut
sub thumbmake  {
    my ( $self, $file ) = @_;
    my $format;
    #my @format_ =["png","gif","jpeg","tiff","ppm"];

  # see Imager::Files for information on the read() method
  #die($file);
    my $img = Imager->new( file => $file )
    or die Imager->errstr();

    $file =~ s/\.[^.]*$//;

    # Create smaller version
    # documented in Imager::Transformations
    # my $thumb = $img->scale(scalefactor=>.3);
    my $thumb = $img->scale( xpixels => 128, ypixels => 128 );
  

  # Autostretch individual channels
    $thumb->filter( type => 'autolevels' );
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
            last SAVE ;
    }
  }
 
}


__PACKAGE__->meta->make_immutable;
1;
