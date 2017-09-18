conf = configuration_data()
conf.set('prefix', get_option('prefix'))
conf.set('exec_prefix', get_option('prefix'))
conf.set('libdir', join_paths (get_option ('prefix'),get_option ('libdir')))
conf.set('VERSION', meson.project_version ())
conf.set('API_VERSION', API_VERSION)

configure_file(input : 'gtktester.pc.in',
	output : 'gtktester-@0@.pc'.format(API_VERSION),
	configuration : conf,
	install : true,
	install_dir : join_paths(get_option('libdir'), 'pkgconfig'))
