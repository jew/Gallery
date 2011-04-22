package Gallery::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    #Set the location for TT files
    INCLUDE_PATH => [
        Gallery->path_to( 'root', 'template' ),
    ],
    WRAPPER => 'wrapper.tt',
);




=head1 NAME

Gallery::View::HTML - TT View for Gallery

=head1 DESCRIPTION

TT View for Gallery.

=head1 SEE ALSO

L<Gallery>

=head1 AUTHOR

jew,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
