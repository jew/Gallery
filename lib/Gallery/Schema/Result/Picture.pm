package Gallery::Schema::Result::Picture;

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

Gallery::Schema::Result::Picture

=cut

__PACKAGE__->table("pictures");

=head1 ACCESSORS

=head2 picture_id

  data_type: 'integer'
  is_nullable: 0

=head2 description

  data_type: 'varchar'
  is_nullable: 1

=head2 album_id

  data_type: 'integer'
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "picture_id",
  { data_type => "integer", is_nullable => 0 },
  "description",
  { data_type => "varchar", is_nullable => 1 },
  "album_id",
  { data_type => "integer", is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("picture_id", "album_id", "user_id");
#set relationships
__PACKAGE__-> belongs_to( "albums","Gallery::Schema::Result::Album",
	{"foreign.picture_id"=>"self.picture_id"},
);

# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-04-12 13:56:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nw7MsLKHQBqjYemJdOYWLg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
