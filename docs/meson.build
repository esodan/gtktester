valadoc = find_program ('valadoc')
outdir =VERSIONED_CAMEL_CASE_NAME
valacapi = run_command ('valac', '--api-version')
driver = '--driver='+valacapi.stdout().strip()
pkgname = '--package-name='+VERSIONED_CAMEL_CASE_NAME
pkgversion = '--package-version='+PROJECT_VERSION
vapidirlib = '--vapidir='+join_paths (meson.current_source_dir (),'src')
docsdir = join_paths (get_option ('datadir'), 'devhelp','books')

custom_target ('valadocs',
		input : valasources,
		output : outdir,
		command : [valadoc,
			driver,
			'--doclet=devhelp',
			'--force',
			pkgname,
			pkgversion,
			'--pkg=gxml-0.16',
			'--pkg=gtk+-3.0',
			vapidirlib,
			'--directory=@OUTDIR@',
			valasources],
		install : true,
		install_dir : docsdir)
