project('gtktester', [ 'vala', 'c'], version : '1.1.0')

PROJECT_NAME = meson.project_name()
API_VERSION = '1'
PROJECT_VERSION = meson.project_version ()
VERSIONED_PROJECT_NAME = PROJECT_NAME+'-'+API_VERSION
CAMEL_CASE_NAME = 'Gtkt'
VERSIONED_CAMEL_CASE_NAME = CAMEL_CASE_NAME +'-'+ API_VERSION

gtk = dependency('gtk+-3.0')
gxml = dependency('gxml-0.16')

VALADEPS = 'gtk-3.0'
PCDEPS = 'gtk-3.0'

inc_rooth = include_directories ('.')
inc_rooth_dep = declare_dependency (include_directories : inc_rooth)

add_project_arguments(['--target-glib=2.50'],
                      language: 'vala')

#subdir('po')
subdir('src')
subdir('data')
subdir('docs')
