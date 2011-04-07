package Gallery::View::LOGIN;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

Gallery::View::LOGIN - TT View for Gallery

=head1 DESCRIPTION

TT View for Gallery.

=head1 SEE ALSO

L<Gallery>

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


sub login :Global {
        my ( $self, $c ) = @_;
        
        $c->stash(template => 'login.tt');
    }

1;
