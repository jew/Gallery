package Gallery::Schema::Result::UserComment;

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

Gallery::Schema::Result::UserComment

=cut

__PACKAGE__->table("user_comments");

=head1 ACCESSORS

=head2 user_id

  data_type: (empty string)
  is_nullable: 0

=head2 comment_id

  data_type: (empty string)
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "", is_nullable => 0 },
  "comment_id",
  { data_type => "", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("user_id", "comment_id");
#set relationship
__PACKAGE__-> belongs_to( "users","Gallery::Schema::Result::User",
	{"foreign.user_id"=>"self.id"},);
__PACKAGE__-> belongs_to( "comments","Gallery::Schema::Result::Comment",
	{"foreign.comment_id"=>"self.comment_id"},);
# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-04-12 13:56:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WnIdgoZJzCZuFQVgWewHbQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
