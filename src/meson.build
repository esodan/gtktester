vapidir = join_paths (get_option('datadir'),'vala','vapi')
GIR_NAME= VERSIONED_CAMEL_CASE_NAME+'.gir'
TYPELIB_NAME= VERSIONED_CAMEL_CASE_NAME+'.typelib'
VAPI_NAME = VERSIONED_PROJECT_NAME+'.vapi'

conf = configuration_data()
conf.set('prefix', get_option('prefix'))
conf.set('exec_prefix', get_option('prefix'))
conf.set('libdir', join_paths (get_option ('prefix'),get_option ('libdir')))
conf.set('includedir', join_paths (get_option ('includedir'), VERSIONED_PROJECT_NAME))
conf.set('VALADEPS', VALADEPS)
conf.set('PROJECT_NAME', PROJECT_NAME)
conf.set('PCDEPS', PCDEPS)
conf.set('PROJECT_VERSION', PROJECT_VERSION)
conf.set('API_VERSION', API_VERSION)

configure_file(input : 'gtktester.deps.in',
	output : 'gtktester-@0@.deps'.format(API_VERSION),
	configuration : conf,
	install : true,
	install_dir : vapidir)

nsinfo = configure_file(input : 'gtktester-namespace.vala.in',
	output : 'gtktester-namespace.vala',
	configuration : conf)
namespaceinfo_dep = declare_dependency (sources : nsinfo)

confh = configuration_data ()
confh.set_quoted('PACKAGE_LOCALE_DIR', join_paths(get_option('prefix'), get_option('datadir'), 'locale'))
confh.set_quoted('GETTEXT_PACKAGE', PROJECT_NAME)
configure_file(output : 'config.h',
	configuration : confh)

# Resources sources
resfiles = files([
	'gtktester.ui',
	'gtkt-headerbar.ui'
])

gresg = find_program('gresg')
resources=custom_target('resources',
	command: [
		gresg,
		'--prefix', '/org/gnome',
		'--file', '@OUTPUT@',
		'@INPUT@'
	],
	output : 'resources.xml',
	input : resfiles
)

glib_compile_resources = find_program ('glib-compile-resources')
resourcesc = custom_target ('resources-c',
	input : resources,
	output : 'resources.c',
	command : [
		glib_compile_resources,
		'--sourcedir='+meson.current_source_dir (),
		'--generate-source',
		'--target', '@OUTPUT@',
		'--internal',
		'@INPUT@'
	],
	depends : resources
)
resourcesh = custom_target ('resources-h',
	input : resources,
	output : 'resources.h',
	command : [
		glib_compile_resources,
		'--sourcedir='+meson.current_source_dir (),
		'--generate-source',
		'--target', '@OUTPUT@',
		'--internal',
		'@INPUT@'
	],
	depends : resources
)

resources_dep = declare_dependency ( sources : [ resourcesc, resourcesh])

valasources = files ([
	'gtktester.vala',
	'gtkt-headerbar.vala'
])

sources = files ([
])

inc_libh = include_directories ('.')
inc_libh_dep = declare_dependency (include_directories : inc_libh)
add_project_arguments(['--gresources', resources.full_path (),
                        '--gresourcesdir', meson.current_source_dir ()],
                      language: 'vala')

lib = library(VERSIONED_PROJECT_NAME,
	valasources+sources,
	version : PROJECT_VERSION,
	vala_header : PROJECT_NAME+'.h',
	vala_vapi : VAPI_NAME,
	vala_gir : GIR_NAME,
	dependencies : [ gtk, namespaceinfo_dep, resources_dep ],
	install : true,
	install_dir : [
		get_option('libdir'),
		join_paths (get_option('includedir'),VERSIONED_PROJECT_NAME),
		vapidir,
		true
	])

g_ir_compiler = find_program('g-ir-compiler')
custom_target('typelib',
	command: [
		g_ir_compiler,
		'--shared-library', 'lib'+PROJECT_NAME+'-@0@.so'.format (API_VERSION),
		'--output', '@OUTPUT@',
		join_paths(meson.current_build_dir(), GIR_NAME)
	],
	output: TYPELIB_NAME,
	depends: lib,
	install: true,
	install_dir: join_paths(get_option('libdir'), 'girepository-1.0'))

# GtktApp

files_gtktapp = files([
	'gtktapp.vala'
])
gtktapp = executable('gtktapp', files_gtktapp,
	dependencies : [ gtk, namespaceinfo_dep, resources_dep ],
	link_with : lib)

