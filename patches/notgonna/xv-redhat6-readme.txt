From: root@ns.bulnet.com on behalf of Assen Totin [assen@bulnet.bg]
Sent: Friday, September 24, 1999 6:30 PM
To: xvtech@devo.dccs.upenn.edu
Subject: (no subject)

Hi!

As a long-time Linux fan, I was sorry not to find your XV in the new Red
Hat Linux 6.0 distribution any more. But - once in love, forever in love
-- 

I got the source for XV 3.10a from ftp://ftp.linuxberg.com

Paraphrasing your README, to me compiling it was the same pleasure as
writing - to you.  :-)

But seriously - in order to compile, two updates to the source had to be
made - and I guess it's not bad to mention them for all these newbies
that get scared whenever they see a "*** Error 1 ***" message.

First, in the header file xv.h lines 119-121 should be commented out,
otherwise you get an "already defined in stdio.h" error and compilation
aborts:

/* #  ifndef __NetBSD__
     extern char *sys_errlist[];     this too... 
#  endif */ 

Second, in the machine-specific options in the Makefile the Linux once
should contain the exact path to X11 libraries: -L/usr/X11/lib -
otherwise make doesn't find them. (I haven't checked where it looks for
them, but all current Linux distributions I know of come with XFree86
pre-compiled and installed with this very path.) So, line 105 reads:

MCHN = -DLINUX -L/usr/X11R6/lib

Regards,

Assen Totin


---------------------

NOTE: On certain LINUX systems, you may run into the BSD types (u_long, etc)
not being defined.  If this happens ("parse error before 'u_long'"-style
messages when you compile), you'll need to make two more minor changes.

In the top-level XV Makefile, find and uncomment the following line:
BSDTYPES = -DBSDTYPES

If you're going to be compiling the included TIFF library (rather than linking
to a pre-built system-wide version, or whatever), you'll also need to edit
the tiff/Makefile, and add '-DBSDTYPES' to the end of the 'COPTS' line:

COPTS = -O -DBSDTYPES

Cheers,

--jhb




