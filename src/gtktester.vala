/* gtktester.vala
 *
 * Copyright (C) 2017 Daniel Espinosa
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;

namespace Gtkt {

  public errordomain WindowTesterError {
    DUPLICATED_TEST_CASE_ERROR
  }
  [CCode (has_target = false, type = "GCallback")]
  public delegate bool TestCaseFunc (WindowTester tester);

  [GtkTemplate (ui="/org/gnome/gtktester.ui")]
  public class WindowTester : Gtk.Window {
    [GtkChild]
    private Gtk.TextBuffer description;
    [GtkChild]
    private Gtk.Label lclosing;
    [GtkChild]
    private Gtk.Image image;
    [GtkChild]
    private Gtk.HeaderBar headerbar;
    [GtkChild]
    private Gtk.Box   widget_box;
    [GtkChild]
    private Gtk.Button bfails;
    [GtkChild]
    private Gtk.Button bnexttest;
    [GtkChild]
    private Gtk.ListBox lfails;

    private int _nfails = 0;
    private int _current_ntest = 0;
    internal class Test : Object {
      public string name { get; set; }
      public string description { get; set; }
    }
    private GLib.Queue<Test> _tests = new Queue<Test> ();
    private Gtk.Widget _widget;

    /**
     * Widget under test.
     */
    public Gtk.Widget widget {
      get { return widget; }
      set {
        if (_widget != null) {
          widget_box.remove (_widget);
        }
        _widget = value;
        widget_box.pack_start (_widget);
        widget_box.show_all ();
      }
    }

    /**
     * Number of current fails
     */
    public int fails { get { return _nfails; } set { _nfails = value; } }
    /**
     * Time before autoclose window.
     */
    public int timeout { get; set; default = 1; }
    /**
     * Number of tests
     */
    public int ntests { get { return (int) _tests.length; } }
    /**
     * Current test number
     */
    public int current_ntest { get { return _current_ntest; } }
    /**
     * Disable autoclose to wait for events
     */
    public bool waiting_for_event { get; set; default = false; }

    /**
     * Event to initialize a test.
     */
    public signal void initialize ();
    /**
     * Event to signal test are starte to run
     */
    public signal void running ();
    /**
     * Signal for all tests finished
     */
    public signal void finished ();
    /**
     * Signal to check if actual conditions in widget met assertions
     */
    public signal void check ();

    construct {
      this.destroy.connect (()=>{
        Gtk.main_quit ();
      });
      this.show.connect (()=>{
        try { run (); } catch { assert_not_reached (); }
      });
      bnexttest.clicked.connect (()=>{
        next_test ();
      });
    }

    /**
     * Updates information about current test
     */
    public void update () {
      if ((_current_ntest - 1) >= _tests.length) return;
      if (_current_ntest == 0) {
        headerbar.subtitle = "NO CURRENT TEST";
        description.set_text ("");
      } else {
        headerbar.subtitle = _tests.peek_nth (_current_ntest - 1).name;
        description.set_text (_tests.peek_nth (_current_ntest - 1).description);
      }
    }

    /**
     * Switch to next test.
     */
    public void next_test () {
      _current_ntest++;
      if (_current_ntest > _tests.length) {
        finished ();
        return;
      }
      update ();
      initialize ();
    }

    /**
     * Add a new test with a name and a description
     */
    public void add_test (string name, string desc) {
      var t = new Test ();
      t.name = name;
      t.description = desc;
      _tests.push_tail (t);
    }

    /**
     * Start running tests
     */
    public void run () throws GLib.Error {
      image.icon_name = "gtk-media-play";
      if (_nfails == 0)
        image.icon_name = "gtk-apply";
      else
        image.icon_name = "gtk-dialog-warning";
      bfails.label = _nfails.to_string ();
      next_test ();
      GLib.Timeout.add (1000, ()=>{
        if (waiting_for_event) {
          GLib.message ("Waiting for events...");
          if (!(lclosing is Gtk.Label))
            GLib.message ("Label lclossing doesn't exists!!!!");
          else
            lclosing.label = "Waiting for Events...";
          return true;
        }
        if (--timeout > 0) {
          GLib.message ("Closing in ..."+timeout.to_string ());
          lclosing.label = "Closing in ... "+timeout.to_string ();
          return true;
        }
        this.destroy ();
        return false;
      });
      running ();
    }
  }

  private class ErrorMessage : Gtk.Grid {
    private Gtk.Label ltcase;
    private Gtk.Label lmessage;
    construct {
      lmessage = new Gtk.Label ("No message");
      ltcase = new Gtk.Label ("/case");
      attach (lmessage, 0,0,1,1);
      attach (ltcase,0,1,1,1);
    }
    public ErrorMessage (string tcase, string msg) {
      lmessage.label = tcase +": "+ msg;
    }
  }

  /**
   * Test case with a method to call.
   */
  public class TestCase : Object {
    public string name;
    public TestCaseFunc* func;
  }
}
