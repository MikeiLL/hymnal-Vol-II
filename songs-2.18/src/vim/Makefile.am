EXTRA_DIST = bitmaps/sgen.bmp bitmaps/qcon.bmp bitmaps/qcoff.bmp ftdetect/sbd.vim ftplugin/songbook.vim ftplugin/tex.vim spell/wordlist.txt spell/songbook.latin1.spl syntax/songbook.vim

installdirs-local:
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/bitmaps
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/ftdetect
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/ftplugin
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/spell
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/syntax

install-data-local: bitmaps/sgen.bmp bitmaps/qcon.bmp bitmaps/qcoff.bmp ftdetect/sbd.vim ftplugin/songbook.vim ftplugin/tex.vim spell/songbook.latin1.spl syntax/songbook.vim
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/bitmaps
	$(INSTALL_DATA) $(srcdir)/bitmaps/sgen.bmp $(DESTDIR)$(vimfilesdir)/bitmaps
	$(INSTALL_DATA) $(srcdir)/bitmaps/qcon.bmp $(DESTDIR)$(vimfilesdir)/bitmaps
	$(INSTALL_DATA) $(srcdir)/bitmaps/qcoff.bmp $(DESTDIR)$(vimfilesdir)/bitmaps
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/ftdetect
	$(INSTALL_DATA) $(srcdir)/ftdetect/sbd.vim $(DESTDIR)$(vimfilesdir)/ftdetect
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/ftplugin
	$(INSTALL_DATA) $(srcdir)/ftplugin/songbook.vim $(DESTDIR)$(vimfilesdir)/ftplugin
	$(INSTALL_DATA) $(srcdir)/ftplugin/tex.vim $(DESTDIR)$(vimfilesdir)/ftplugin
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/spell
	$(INSTALL_DATA) $(srcdir)/spell/songbook.latin1.spl $(DESTDIR)$(vimfilesdir)/spell
	-$(MKDIR_P) $(DESTDIR)$(vimfilesdir)/syntax
	$(INSTALL_DATA) $(srcdir)/syntax/songbook.vim $(DESTDIR)$(vimfilesdir)/syntax

uninstall-local:
	-rm -f $(DESTDIR)$(vimfilesdir)/bitmaps/sgen.bmp $(DESTDIR)$(vimfilesdir)/bitmaps/qcon.bmp $(DESTDIR)$(vimfilesdir)/bitmaps/qcoff.bmp $(DESTDIR)$(vimfilesdir)/ftdetect/sbd.vim $(DESTDIR)$(vimfilesdir)/ftplugin/songbook.vim $(DESTDIR)$(vimfilesdir)/ftplugin/tex.vim $(DESTDIR)$(vimfilesdir)/spell/songbook.latin1.spl $(DESTDIR)$(vimfilesdir)/syntax/songbook.vim

