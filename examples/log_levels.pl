#!perl

use strict;
use warnings;

use MyDebugLog;

MyDebugLog->set_log_level( LOG_LEVEL_NOTICE );

LOG_NOTICE  'Start script', 
            'Nice weather we\'re having';
LOG_WARNING 'Slight badness';
LOG_SEVERE  'BADNESS happened';
LOG_FATAL    23, 'DEADLY BADNESS happened';
