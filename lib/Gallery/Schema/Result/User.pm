package Gallery::Schema::Result::User;

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

Gallery::Schema::Result::User

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 1

=head2 password

  data_type: 'varchar'
  is_nullable: 1

=head2 email

  data_type: 'varchar'
  is_nullable: 1

=head2 first_name

  data_type: 'varchar'
  is_nullable: 1

=head2 last_name

  data_type: 'varchar'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 1 },
  "password",
  { data_type => "varchar", is_nullable => 1 },
  "email",
  { data_type => "varchar", is_nullable => 1 },
  "first_name",
  { data_type => "varchar", is_nullable => 1 },
  "last_name",
  { data_type => "varchar", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("user_id");


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-04-10 15:31:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:J14v+mazSOJjRRdagWc6qQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
