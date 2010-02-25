package MyDebugLog;

use strict;
use warnings;

use Carp qw(croak);

use Log::WithCallbacks;

use constant {
    LOG_LEVEL_NOTICE   => 0,
    LOG_LEVEL_WARNING  => 1,
    LOG_LEVEL_SEVERE   => 2,
    LOG_LEVEL_CRITICAL => 3,
    LOG_LEVEL_FATAL    => 4,
};

my $DEBUG;
my $LOG_LEVEL = 3;

# Custom import injects logging routines and initializes the logging object.
sub import {
    my $export_to = caller;

    # Export functions 
    no strict 'refs';
    *{"${export_to}::$_"} = \&{$_} 
        for qw(
            LOG_NOTICE   
            LOG_WARNING 
            LOG_SEVERE 
            LOG_CRITICAL 
            LOG_FATAL 

            LOG_LEVEL_NOTICE 
            LOG_LEVEL_WARNING
            LOG_LEVEL_SEVERE
            LOG_LEVEL_CRITICAL
            LOG_LEVEL_FATAL
        );

    # Initialize $DEBUG as LWC object if needed.
    return 1 if $DEBUG;

    my $class = shift;
    my $path  = shift || 'DEBUG.log';

    $DEBUG = Log::WithCallbacks->new( $path, \&_format_message );
    $DEBUG->open;

    return 1;
}

sub log_level { $LOG_LEVEL }
sub set_log_level {
    shift;
    my $level = shift;

    croak "Invalid log level" 
        unless $level >= LOG_LEVEL_NOTICE 
           and $level <= LOG_LEVEL_FATAL();

    $LOG_LEVEL = $level;
}

sub LOG_NOTICE   { $DEBUG->entry([ LOG_LEVEL_NOTICE,   \@_]) }
sub LOG_WARNING  { $DEBUG->entry([ LOG_LEVEL_WARNING,  \@_]) }
sub LOG_SEVERE   { $DEBUG->entry([ LOG_LEVEL_SEVERE,   \@_]) }
sub LOG_CRITICAL { $DEBUG->entry([ LOG_LEVEL_CRITICAL, \@_]) }
sub LOG_FATAL    { 
    my $error_code = shift;
    warn $DEBUG->entry([ LOG_LEVEL_FATAL,    \@_]);
    exit $error_code;
}

sub _format_message {
    my ($level, $lines);
    eval { ($level,$lines) = @{shift()} };
    die "Invalid message passed to formatter\n" 
        unless defined $level;

    return unless $level >= $LOG_LEVEL;

    my @LEVELS = (
        'NOTICE:  ',
        'WARNING: ',
        'SEVERE:  ',
        'CRITICAL:',
        'FATAL:   ',
    );
    my $level_string = $LEVELS[$level];

    return join "", map "$level_string $_\n", @$lines;
}

1;
