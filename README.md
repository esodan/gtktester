# gtktester
Library with widgets for Gtk+ widget tests

# Using in your Project
In order to use GtkTester in your project you should add unit tests support, using GLib Test suite is a good idea. May you want to check at GXml project to find how in Vala.

# Is not limited Vala projects
Vala provides a set of C API you can use, but is your choice.

# Setup your test case
First create an instance of your widget and an instance of Gtkt.WindowTester, then set your widget to "widget" property in tester window.

At this momment you can call Gtk.run (), Gtkt.WindowTester will be initialized and showing your widget as a child. After 1 second, window will be destroyed automatically. It is useful to find if your widget is initialized correctly and can be attached to other containers.

# Setup basic interactive tests

Once you have make initial setup of your widget, this includes to any stuff like load files and make any calculation to be set to your widget, may you want to interact with it and check if is responding according your expectetions.

Make sure your widget have public API you can use to setup it or get data to check against.

Set Gtkt.WindowTester.waiting_for_event = true, then Gtk.run (), your test window will be shown until you close it manually or testcases are finished. This will help you to check manually if information shown correspond with the one you set by your widget's API.

# Initialize singnal

run() method is automatically called when WindowTester is shown. This method calls next_test() to setup your test case information, like title and description, set them using add_test().

Once setup is finished, you can connect a handler to initialize() signal, then you can setup your test case, make sure you use current_ntest property to know test number to setup. Once finished may you want to call check() signal, then in there and test number, check conditions in your widget.

# Limitations
WindowTester will have access only to public API in your widget, so add them in order to check (by assertions may be), if currect information or actions are taken.
