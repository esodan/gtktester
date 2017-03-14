using GLib;
[CCode (cprefix = "", lower_case_cprefix = "", cheader_filename = "vala_resources.h")]
namespace Resources {
  [CCode (cname="resources_get_resource")]
  Resource get_resource ();
}
