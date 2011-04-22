package Gallery::Schema::Result::Album;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Gallery::Schema::Result::Album

=cut

__PACKAGE__->table("albums");

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
  { data_type => "integer", is_nullable => 0 },
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
__PACKAGE__->set_primary_key("album_id", "user_id");
#set relationships
__PACKAGE__-> belongs_to( "users","Gallery::Schema::Result::User",

	{ user_id => "users"},);
__PACKAGE__-> has_many( "pictures" => 'Gallery::Schema::Result::Picture',
{"foreign.album_id"=>"self.album_id"},
);
# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-04-12 13:56:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gCf6kkiNryGAXIO9g17cFg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
