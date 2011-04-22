package Gallery::Schema::Result::Comment;

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

Gallery::Schema::Result::Comment

=cut

__PACKAGE__->table("comments");

=head1 ACCESSORS

=head2 comment_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 comment

  data_type: 'varchar'
  is_nullable: 1

=head2 c_date

  data_type: 'datetime'
  default_value: CURRENT_DATE
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "comment_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "comment",
  { data_type => "varchar", is_nullable => 1 },
  
  "picture_id",
  { data_type => "integer", is_nullable => 1 },
  "album_id",
  { data_type => "integer", is_nullable => 1 },
  
  
  
  "c_date",
  {
    data_type     => "datetime",
    default_value => \"CURRENT_DATE",
    is_nullable   => 1,
  },
);
__PACKAGE__->set_primary_key("comment_id");
#set relationships
__PACKAGE__-> has_many( 'usercomments' => 'Gallery::Schema::Result::UserComment', { "foreign.comment_id" => "self.comment_id" });
__PACKAGE__-> many_to_many( uses => 'usercomments', 'user');
# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-04-12 13:56:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+s79nlj9/GyBpV0DO5hvwg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
