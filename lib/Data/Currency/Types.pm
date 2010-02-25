package Data::Currency::Types;

use MooseX::Types -declare => [ qw(Amount CurrencyCode Format) ];

use MooseX::Types::Moose qw(Num Str);
use Locale::Currency qw(code2currency);

class_type Amount, { class => 'Math::BigFloat' };

coerce Amount,
    from Num,
    via { Math::BigFloat->new($_, undef, -2) };

subtype CurrencyCode,
    as Str,
    where { !defined($_) || ($_ =~ /^[A-Z]{3}$/ && defined(code2currency($_))) },
    message { 'String is not a valid 3 letter currency code.' };

enum Format,
    ( qw(FMT_COMMON FMT_HTML FMT_NAME FMT_STANDARD FMT_SYMBOL) );

1;