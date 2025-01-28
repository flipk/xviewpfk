
CC = gcc
CCOPTS = -O 

BINDIR = /usr/local/bin
MANDIR = /usr/local/man/man1
MANSUF = 1
LIBDIR = /usr/local/lib

buildit: all

JPEGDIR = jpeg-6b
JPEGINC = -I$(JPEGDIR)
JPEGLIB = $(JPEGDIR)/libjpeg.a

$(JPEGLIB):
	cd $(JPEGDIR) ; make

TIFFDIR = tiff
TIFFINC = -I$(TIFFDIR)
TIFFLIB = $(TIFFDIR)/libtiff.a

$(TIFFLIB):
	cd $(TIFFDIR) ; make

CFLAGS = $(CCOPTS) $(JPEGINC) $(TIFFINC) \
	$(NODIRENT) $(VPRINTF) $(TIMERS) $(UNIX) $(BSDTYPES) $(RAND) \
	$(DXWM) $(MCHN)

LIBS = -lX11 $(JPEGLIB) $(TIFFLIB) -lm

OBJS = 	xv.o xvevent.o xvroot.o xvmisc.o xvimage.o xvcolor.o xvsmooth.o \
	xv24to8.o xvgif.o xvpm.o xvinfo.o xvctrl.o xvscrl.o xvalg.o \
	xvgifwr.o xvdir.o xvbutt.o xvpbm.o xvxbm.o xvgam.o xvbmp.o \
	xvdial.o xvgraf.o xvsunras.o xvjpeg.o xvps.o xvpopup.o xvdflt.o \
	xvtiff.o xvtiffwr.o xvpds.o xvrle.o xviris.o xvgrab.o vprintf.o \
	xvbrowse.o xvtext.o xvpcx.o xviff.o xvtarga.o xvxpm.o xvcut.o \
	xvxwd.o xvfits.o

MISC = README INSTALL CHANGELOG IDEAS



.c.o:	; $(CC) $(CFLAGS) -c $*.c



all: $(JPEGLIB) $(TIFFLIB) xv bggen vdcomp xcmap xvpictoppm


xv: $(OBJS) $(JPEGLIB) $(TIFFLIB)
	$(CC) -o xv $(CFLAGS) $(OBJS) $(LIBS)

bggen: bggen.c
	$(CC) $(CFLAGS) -o bggen bggen.c $(LIBS)

vdcomp: vdcomp.c
	$(CC) $(CFLAGS) -o vdcomp vdcomp.c

xcmap:  xcmap.c
	$(CC) $(CFLAGS) -o xcmap xcmap.c $(LIBS)

xvpictoppm:  xvpictoppm.c
	$(CC) $(CFLAGS) -o xvpictoppm xvpictoppm.c


clean:
	rm -f $(OBJS) xv
	rm -f bggen vdcomp xcmap xvpictoppm
	cd $(JPEGDIR) ; make clean
	cd $(TIFFDIR) ; make clean


install: all
	cp xv bggen vdcomp xcmap xvpictoppm $(BINDIR)
	cp docs/xv.man     $(MANDIR)/xv.$(MANSUF)
	cp docs/bggen.man  $(MANDIR)/bggen.$(MANSUF)
	cp docs/xcmap.man  $(MANDIR)/xcmap.$(MANSUF)
	cp docs/xvp2p.man  $(MANDIR)/xvpictoppm.$(MANSUF)
	cp docs/vdcomp.man $(MANDIR)/vdcomp.$(MANSUF)
	cp docs/xvdocs.ps* $(LIBDIR)

$(OBJS):   xv.h config.h


################# bitmap dependencies ####################

xv.o:      	bits/icon bits/iconmask bits/runicon bits/runiconm
xv.o:      	bits/cboard50 bits/gray25 

xvbrowse.o:	bits/br_file bits/br_dir bits/br_exe bits/br_chr bits/br_blk
xvbrowse.o:	bits/br_sock bits/br_fifo bits/br_error bits/br_unknown
xvbrowse.o:	bits/br_cmpres bits/br_gif bits/br_pm bits/br_pbm
xvbrowse.o:	bits/br_sunras bits/br_bmp bits/br_utah bits/br_iris
xvbrowse.o:	bits/br_pcx bits/br_jfif bits/br_tiff bits/br_pds 
xvbrowse.o:	bits/br_ps bits/br_iff bits/br_targa bits/br_xpm
xvbrowse.o:	bits/br_trash bits/fcurs bits/fccurs bits/fdcurs bits/fcursm
xvbrowse.o:     bits/br_xwd

xvbutt.o:	bits/cboard50 bits/rb_frame bits/rb_frame1 bits/rb_top
xvbutt.o:	bits/rb_bot bits/rb_dtop bits/rb_dbot bits/rb_body
xvbutt.o:	bits/rb_dot bits/cb_check bits/mb_chk

xvctrl.o:	bits/gray25 bits/gray50 bits/i_fifo bits/i_chr bits/i_dir
xvctrl.o: 	bits/i_blk bits/i_lnk bits/i_sock bits/i_exe bits/i_reg
xvctrl.o:	bits/h_rotl bits/h_rotr bits/fliph bits/flipv bits/p10
xvctrl.o:	bits/m10 bits/cut bits/copy bits/paste bits/clear 
xvctrl.o:	bits/uicon bits/oicon1 bits/oicon2 bits/icon
xvctrl.o:	bits/padimg bits/annot

xvcut.o:	bits/cut bits/cutm bits/copy bits/copym

xvdflt.o:	bits/logo_top bits/logo_bot bits/logo_out bits/xv_jhb
xvdflt.o:	bits/xv_cpyrt bits/xv_rev bits/xv_ver
xvdflt.o:	bits/xf_left bits/xf_right bits/font5x9.h
xvdflt.o:       xvdflt.h

xvdial.o:	bits/dial_cw1 bits/dial_ccw1 bits/dial_cw2 bits/dial_ccw2

xvdir.o:	bits/d_load bits/d_save

xvevent.o:	bits/dropper bits/dropperm bits/pen bits/penm 
xvevent.o:	bits/blur bits/blurm

xvgam.o:	bits/h_rotl bits/h_rotr bits/h_flip bits/h_sinc bits/h_sdec
xvgam.o:	bits/h_sat bits/h_desat

xvgraf.o:	bits/gf1_addh bits/gf1_delh bits/gf1_line bits/gf1_spln
xvgraf.o:	bits/gf1_rst bits/gf1_gamma

xvinfo.o:	bits/penn bits/pennnet

xvmisc.o:	bits/fc_left bits/fc_leftm bits/fc_left1 bits/fc_left1m
xvmisc.o:	bits/fc_mid bits/fc_midm bits/fc_right1 bits/fc_right1m
xvmisc.o:	bits/fc_right bits/fc_rightm

xvpopup.o:	bits/icon

xvroot.o:	bits/root_weave

xvscrl.o:	bits/up bits/down bits/up1 bits/down1 bits/uph bits/downh
xvscrl.o:	bits/uph1 bits/downh1 bits/scrlgray

################# end bitmap dependencies ####################



