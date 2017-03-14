include $(top_srcdir)/gtester.mk

include $(top_srcdir)/vala.mk

TEST_PROGS += $(VALA_TARGET)

DISTCLEANFILES = \
	$(VALA_TARGET) \
	$(NULL)
