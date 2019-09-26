LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# libncurses
LOCAL_SRC_FILES := ncurses/ncurses/tty/hardscroll.c ncurses/ncurses/tty/hashmap.c \
	ncurses/ncurses/tty/lib_mvcur.c ncurses/ncurses/tty/lib_tstp.c \
	ncurses/ncurses/tty/lib_twait.c ncurses/ncurses/tty/lib_vidattr.c \
	ncurses/ncurses/tty/tty_update.c \
	ncurses/ncurses/base/define_key.c ncurses/ncurses/base/keybound.c \
	ncurses/ncurses/base/key_defined.c ncurses/ncurses/base/keyok.c \
	ncurses/ncurses/base/legacy_coding.c ncurses/ncurses/base/lib_addch.c \
	ncurses/ncurses/base/lib_addstr.c ncurses/ncurses/base/lib_beep.c \
	ncurses/ncurses/base/lib_bkgd.c ncurses/ncurses/base/lib_box.c \
	ncurses/ncurses/base/lib_chgat.c ncurses/ncurses/base/lib_clear.c \
	ncurses/ncurses/base/lib_clearok.c ncurses/ncurses/base/lib_clrbot.c \
	ncurses/ncurses/base/lib_clreol.c ncurses/ncurses/base/lib_color.c \
	ncurses/ncurses/base/lib_colorset.c ncurses/ncurses/base/lib_delch.c \
	ncurses/ncurses/base/lib_delwin.c ncurses/ncurses/base/lib_dft_fgbg.c \
	ncurses/ncurses/base/lib_echo.c ncurses/ncurses/base/lib_endwin.c \
	ncurses/ncurses/base/lib_erase.c ncurses/ncurses/base/lib_flash.c \
	ncurses/ncurses/base/lib_freeall.c ncurses/ncurses/base/lib_getch.c \
	ncurses/ncurses/base/lib_getstr.c ncurses/ncurses/base/lib_hline.c \
	ncurses/ncurses/base/lib_immedok.c ncurses/ncurses/base/lib_inchstr.c \
	ncurses/ncurses/base/lib_initscr.c ncurses/ncurses/base/lib_insch.c \
	ncurses/ncurses/base/lib_insdel.c ncurses/ncurses/base/lib_insnstr.c \
	ncurses/ncurses/base/lib_instr.c ncurses/ncurses/base/lib_isendwin.c \
	ncurses/ncurses/base/lib_leaveok.c ncurses/ncurses/base/lib_mouse.c \
	ncurses/ncurses/base/lib_move.c ncurses/ncurses/base/lib_mvwin.c \
	ncurses/ncurses/base/lib_newterm.c ncurses/ncurses/base/lib_newwin.c \
	ncurses/ncurses/base/lib_nl.c ncurses/ncurses/base/lib_overlay.c \
	ncurses/ncurses/base/lib_pad.c ncurses/ncurses/base/lib_printw.c \
	ncurses/ncurses/base/lib_redrawln.c ncurses/ncurses/base/lib_refresh.c \
	ncurses/ncurses/base/lib_restart.c ncurses/ncurses/base/lib_scanw.c \
	ncurses/ncurses/base/lib_screen.c ncurses/ncurses/base/lib_scroll.c \
	ncurses/ncurses/base/lib_scrollok.c ncurses/ncurses/base/lib_scrreg.c \
	ncurses/ncurses/base/lib_set_term.c ncurses/ncurses/base/lib_slkatrof.c \
	ncurses/ncurses/base/lib_slkatron.c ncurses/ncurses/base/lib_slkatr_set.c \
	ncurses/ncurses/base/lib_slkatrset.c ncurses/ncurses/base/lib_slkattr.c \
	ncurses/ncurses/base/lib_slk.c ncurses/ncurses/base/lib_slkclear.c \
	ncurses/ncurses/base/lib_slkcolor.c ncurses/ncurses/base/lib_slkinit.c \
	ncurses/ncurses/base/lib_slklab.c ncurses/ncurses/base/lib_slkrefr.c \
	ncurses/ncurses/base/lib_slkset.c ncurses/ncurses/base/lib_slktouch.c \
	ncurses/ncurses/base/lib_touch.c ncurses/ncurses/base/lib_ungetch.c \
	ncurses/ncurses/base/lib_vline.c ncurses/ncurses/base/lib_wattroff.c \
	ncurses/ncurses/base/lib_wattron.c ncurses/ncurses/base/lib_winch.c \
	ncurses/ncurses/base/lib_window.c ncurses/ncurses/base/nc_panel.c \
	ncurses/ncurses/base/resizeterm.c ncurses/ncurses/base/safe_sprintf.c \
	ncurses/ncurses/base/tries.c ncurses/ncurses/base/use_window.c \
	ncurses/ncurses/base/version.c ncurses/ncurses/base/vsscanf.c \
	ncurses/ncurses/base/wresize.c \
	ncurses/ncurses/tinfo/access.c ncurses/ncurses/tinfo/add_tries.c \
	ncurses/ncurses/tinfo/alloc_entry.c ncurses/ncurses/tinfo/alloc_ttype.c \
	ncurses/ncurses/tinfo/captoinfo.c ncurses/ncurses/tinfo/comp_error.c \
	ncurses/ncurses/tinfo/comp_expand.c ncurses/ncurses/tinfo/comp_hash.c \
	ncurses/ncurses/tinfo/comp_parse.c ncurses/ncurses/tinfo/comp_scan.c \
	ncurses/ncurses/tinfo/db_iterator.c ncurses/ncurses/tinfo/entries.c \
	ncurses/ncurses/tinfo/free_ttype.c ncurses/ncurses/tinfo/getenv_num.c \
	ncurses/ncurses/tinfo/hashed_db.c ncurses/ncurses/tinfo/home_terminfo.c \
	ncurses/ncurses/tinfo/init_keytry.c ncurses/ncurses/tinfo/lib_acs.c \
	ncurses/ncurses/tinfo/lib_baudrate.c ncurses/ncurses/tinfo/lib_cur_term.c \
	ncurses/ncurses/tinfo/lib_data.c ncurses/ncurses/tinfo/lib_has_cap.c \
	ncurses/ncurses/tinfo/lib_kernel.c ncurses/ncurses/tinfo/lib_longname.c \
	ncurses/ncurses/tinfo/lib_napms.c ncurses/ncurses/tinfo/lib_options.c \
	ncurses/ncurses/tinfo/lib_print.c ncurses/ncurses/tinfo/lib_raw.c \
	ncurses/ncurses/tinfo/lib_setup.c ncurses/ncurses/tinfo/lib_termcap.c \
	ncurses/ncurses/tinfo/lib_termname.c ncurses/ncurses/tinfo/lib_tgoto.c \
	ncurses/ncurses/tinfo/lib_ti.c ncurses/ncurses/tinfo/lib_tparm.c \
	ncurses/ncurses/tinfo/lib_tputs.c ncurses/ncurses/tinfo/lib_ttyflags.c \
	ncurses/ncurses/tinfo/make_hash.c ncurses/ncurses/tinfo/name_match.c \
	ncurses/ncurses/tinfo/obsolete.c ncurses/ncurses/tinfo/parse_entry.c \
	ncurses/ncurses/tinfo/read_entry.c ncurses/ncurses/tinfo/read_termcap.c \
	ncurses/ncurses/tinfo/strings.c ncurses/ncurses/tinfo/trim_sgr0.c \
	ncurses/ncurses/tinfo/use_screen.c ncurses/ncurses/tinfo/write_entry.c \
	ncurses/ncurses/trace/lib_trace.c ncurses/ncurses/trace/varargs.c \
	ncurses/ncurses/trace/visbuf.c ncurses/ncurses/codes.c \
	ncurses/ncurses/comp_captab.c ncurses/ncurses/expanded.c \
	ncurses/ncurses/fallback.c ncurses/ncurses/lib_gen.c \
	ncurses/ncurses/lib_keyname.c ncurses/ncurses/names.c \
	ncurses/ncurses/unctrl.c

LOCAL_CFLAGS := -DHAVE_CONFIG_H -U_XOPEN_SOURCE -D_XOPEN_SOURCE=500 \
		-U_POSIX_C_SOURCE -D_POSIX_C_SOURCE=199506L -DNDEBUG

LOCAL_C_INCLUDES := ncurses/include ncurses/ncurses

LOCAL_MODULE := libncurses
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

# libglob
LOCAL_SRC_FILES := glob/glob.c
LOCAL_C_INCLUDES := glob
LOCAL_CFLAGS := -D__USE_BSD -D__BIONIC__
LOCAL_MODULE := libglob
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

# nano
LOCAL_SRC_FILES := src/browser.c src/chars.c src/color.c \
		   src/cut.c src/files.c src/global.c \
		   src/help.c src/history.c src/move.c \
		   src/nano.c src/prompt.c src/rcfile.c \
		   src/search.c src/text.c src/utils.c \
		   src/winio.c

LOCAL_C_INCLUDES := ncurses/include glob

LOCAL_CFLAGS := -DHAVE_CONFIG_H -DSYSCONFDIR=\"/system/etc/nano\"
LOCAL_SHARED_LIBRARIES := libncurses libglob
LOCAL_MODULE := nano
include $(BUILD_EXECUTABLE)
