
#define USE_GUNZIP 1

#ifdef USE_GUNZIP
#  define GUNZIP "/bin/gunzip -q"
#  define UNCOMPRESS GUNZIP
#endif

/***************************************************************************
 * Backing Store:
 * 
 * XV can request that 'Backing Store' may be turned on ('WhenMapped') for 
 * several of its windows, which may help performance over a slow network
 * connection.  However, it has been known to behave strangely (or crash)
 * on some X servers, so it's left here as an option.  If you run into trouble
 * (strange behavior with the image window), you might want to turn it off by
 * changing 'define' to 'undef' in the following line:
 */

#define BACKING_STORE

